#!/usr/bin/env python3
"""
build-guide-pdf.py
Generates Alubys_AI_Dev_System_Guide.pdf from the Markdown source.
Implements the Formatting & Layout Design Blueprint.
"""

import os
import re
import sys
from pathlib import Path

try:
    from reportlab.lib import colors
    from reportlab.lib.pagesizes import letter
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib.enums import TA_LEFT, TA_CENTER, TA_RIGHT
    from reportlab.lib.colors import HexColor
    from reportlab.platypus import (
        BaseDocTemplate, PageTemplate, Frame, Paragraph, Spacer,
        Table, TableStyle, PageBreak, KeepTogether, Image,
        HRFlowable, NextPageTemplate
    )
    from reportlab.pdfgen import canvas as rl_canvas
except ImportError:
    print("ERROR: reportlab is required.")
    print("Install with: pip3 install reportlab Pillow")
    sys.exit(1)

# ── Paths ────────────────────────────────────────────────────────────────────
SCRIPT_DIR   = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
GUIDE_DIR    = PROJECT_ROOT / "_GUIDE"
SOURCE_MD    = GUIDE_DIR / "Alubys_AI_Dev_System_Guide.md"
OUTPUT_PDF   = GUIDE_DIR / "Alubys_AI_Dev_System_Guide.pdf"
ASSETS_DIR   = GUIDE_DIR / "assets"

# ── Colors ───────────────────────────────────────────────────────────────────
C_NAVY       = HexColor('#1a1a2e')   # Cover title
C_HEADER_BG  = HexColor('#1b2a4a')  # Running header bar + table headers
C_BLUE_H2    = HexColor('#1a5276')  # H2 subheadings + TOC entries
C_BLACK      = HexColor('#111827')  # Cover subtitle
C_DARK_GRAY  = HexColor('#374151')  # Cover description
C_MED_GRAY   = HexColor('#9ca3af')  # Cover footer
C_HR         = HexColor('#d1d5db')  # Divider lines
C_ROW_ALT    = HexColor('#f3f4f6')  # Alternating table row
C_CODE_BG    = HexColor('#1e2533')  # Code block background
C_CODE_FG    = HexColor('#e2e8f0')  # Code block text
C_BOX_BG     = HexColor('#f9fafb')  # Callout box background
C_BOX_BLUE   = HexColor('#3b82f6')  # Info callout border
C_BOX_AMBER  = HexColor('#f59e0b')  # Warning callout border
C_BOX_GREEN  = HexColor('#22c55e')  # Tip / key callout border

# Step cards
C_STEP_NUM   = HexColor('#c0392b')  # Red step number
C_STEP_TITLE = HexColor('#1a5276')  # Blue step title

# Mode card header colors (one per mode)
MODE_COLORS  = {
    1: HexColor('#6d28d9'),  # Purple  — Brainstorming
    2: HexColor('#0e7490'),  # Teal    — Planning
    3: HexColor('#065f46'),  # Green   — Execution
    4: HexColor('#92400e'),  # Brown   — Reflection
}

# ── Page geometry ────────────────────────────────────────────────────────────
PW, PH          = letter                   # 612 × 792 pt
M_LEFT          = 0.75 * inch
M_RIGHT         = 0.75 * inch
M_TOP           = 0.55 * inch
M_BOTTOM        = 0.30 * inch
HEADER_H        = 0.32 * inch
GAP_BELOW_HDR   = 0.12 * inch

BODY_W          = PW - M_LEFT - M_RIGHT    # 504 pt
COVER_FRAME_H   = PH - M_TOP - M_BOTTOM   # 730.8 pt  (no header on cover)
BODY_FRAME_TOP  = PH - HEADER_H - GAP_BELOW_HDR   # header flush with top edge
BODY_FRAME_H    = BODY_FRAME_TOP - M_BOTTOM        # ≈ 739 pt  (10.26 in)

# ── Styles ───────────────────────────────────────────────────────────────────
def _s(name, **kw):
    return ParagraphStyle(name, **kw)

S = {
    # Cover
    'cover_title':    _s('cover_title',
                         fontName='Helvetica-Bold', fontSize=32, leading=38,
                         textColor=C_NAVY, alignment=TA_CENTER, spaceAfter=14),
    'cover_subtitle': _s('cover_subtitle',
                         fontName='Helvetica', fontSize=16, leading=20,
                         textColor=C_BLACK, alignment=TA_CENTER, spaceAfter=8),
    'cover_version':  _s('cover_version',
                         fontName='Helvetica', fontSize=11, leading=14,
                         textColor=C_BLACK, alignment=TA_CENTER, spaceAfter=40),
    'cover_desc':     _s('cover_desc',
                         fontName='Helvetica', fontSize=11, leading=17,
                         textColor=C_DARK_GRAY, alignment=TA_CENTER, spaceAfter=4),
    'cover_footer':   _s('cover_footer',
                         fontName='Helvetica', fontSize=9, leading=11,
                         textColor=C_MED_GRAY, alignment=TA_CENTER),

    # TOC
    'toc_heading':    _s('toc_heading',
                         fontName='Helvetica-Bold', fontSize=18, leading=22,
                         textColor=C_NAVY, spaceAfter=6),
    'toc_entry':      _s('toc_entry',
                         fontName='Helvetica', fontSize=10, leading=16,
                         textColor=C_BLUE_H2, leftIndent=12, spaceAfter=2),

    # Section headings
    'h1':             _s('h1',
                         fontName='Helvetica-Bold', fontSize=16, leading=20,
                         textColor=C_NAVY, spaceBefore=6, spaceAfter=4),
    'h2':             _s('h2',
                         fontName='Helvetica-Bold', fontSize=11, leading=14,
                         textColor=C_BLUE_H2, spaceBefore=5, spaceAfter=3),

    # Body
    'body':           _s('body',
                         fontName='Helvetica', fontSize=9, leading=13,
                         textColor=colors.black, spaceAfter=6),
    'body_small':     _s('body_small',
                         fontName='Helvetica', fontSize=8, leading=12,
                         textColor=colors.black, spaceAfter=4),
    'bullet':         _s('bullet',
                         fontName='Helvetica', fontSize=9, leading=13,
                         textColor=colors.black,
                         leftIndent=18, firstLineIndent=0, spaceAfter=2),
    'bullet_sub':     _s('bullet_sub',
                         fontName='Helvetica', fontSize=9, leading=13,
                         textColor=colors.black,
                         leftIndent=32, firstLineIndent=0, spaceAfter=2),

    # Code
    'code':           _s('code',
                         fontName='Courier', fontSize=8, leading=11,
                         textColor=C_CODE_FG),

    # Table cells
    'cell':           _s('cell',
                         fontName='Helvetica', fontSize=8, leading=11,
                         textColor=colors.black),
    'cell_hdr':       _s('cell_hdr',
                         fontName='Helvetica-Bold', fontSize=8, leading=11,
                         textColor=colors.white),
    'cell_code':      _s('cell_code',
                         fontName='Courier', fontSize=7.5, leading=10,
                         textColor=colors.black),

    # Callout
    'callout':        _s('callout',
                         fontName='Helvetica', fontSize=9, leading=13,
                         textColor=colors.black),

    # Footer (centered italic — e.g. *Guide title — v1.0* standalone line)
    'footer':         _s('footer',
                         fontName='Helvetica-Oblique', fontSize=9, leading=11,
                         textColor=C_MED_GRAY, alignment=TA_CENTER,
                         spaceBefore=6, spaceAfter=4),
}

# ── Header canvas ─────────────────────────────────────────────────────────────
class HeaderCanvas(rl_canvas.Canvas):
    """Draws the dark navy running header on every page except page 1 (cover)."""

    def __init__(self, *args, **kwargs):
        rl_canvas.Canvas.__init__(self, *args, **kwargs)
        self._page_states = []

    def showPage(self):
        self._page_states.append(dict(self.__dict__))
        self._startPage()

    def save(self):
        for i, state in enumerate(self._page_states):
            self.__dict__.update(state)
            if i > 0:                         # skip cover (page 1 = index 0)
                self._draw_header(i + 1)      # i+1 = actual page number
            rl_canvas.Canvas.showPage(self)
        rl_canvas.Canvas.save(self)

    def _draw_header(self, page_num):
        y = PH - HEADER_H   # flush with top edge of page — no gap
        # Navy bar
        self.setFillColor(C_HEADER_BG)
        self.rect(0, y, PW, HEADER_H, fill=1, stroke=0)
        # Title
        self.setFillColor(colors.white)
        self.setFont('Helvetica-Bold', 9)
        text_y = y + HEADER_H * 0.30
        self.drawString(M_LEFT, text_y,
                        'Alubys AI Development System — Reference Guide')
        # Page number (plain number, top-right)
        self.drawRightString(PW - M_RIGHT, text_y, str(page_num))


# ── Inline markdown → ReportLab XML ──────────────────────────────────────────
def _xml(text):
    """Escape XML special chars and convert inline markdown."""
    text = text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
    # Inline code
    text = re.sub(r'`([^`]+)`',
                  r'<font name="Courier" size="8">\1</font>', text)
    # Bold
    text = re.sub(r'\*\*(.+?)\*\*', r'<b>\1</b>', text)
    # Italic
    text = re.sub(r'\*(.+?)\*', r'<i>\1</i>', text)
    return text


# ── Code block ────────────────────────────────────────────────────────────────
def _code_block(lines):
    """Return flowables for a dark-background code block."""
    escaped = []
    for ln in lines:
        e = ln.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
        escaped.append(e if e.strip() else ' ')
    text = '<br/>'.join(escaped)
    para = Paragraph(text, S['code'])
    tbl = Table([[para]], colWidths=[BODY_W])
    tbl.setStyle(TableStyle([
        ('BACKGROUND',    (0, 0), (-1, -1), C_CODE_BG),
        ('LEFTPADDING',   (0, 0), (-1, -1), 10),
        ('RIGHTPADDING',  (0, 0), (-1, -1), 10),
        ('TOPPADDING',    (0, 0), (-1, -1), 8),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 8),
    ]))
    return [Spacer(1, 4), tbl, Spacer(1, 6)]


# ── Table ─────────────────────────────────────────────────────────────────────
_SEP_RE = re.compile(r'^\|[\s\-:|]+\|$')

def _parse_table_rows(lines):
    rows = []
    for ln in lines:
        if _SEP_RE.match(ln.strip()):
            continue
        cells = [c.strip() for c in ln.strip().strip('|').split('|')]
        rows.append(cells)
    return rows

def _table_flowable(rows):
    if not rows:
        return None
    col_n = max(len(r) for r in rows)
    rows  = [r + [''] * (col_n - len(r)) for r in rows]
    col_w = BODY_W / col_n

    def _cell(text, hdr=False):
        style = S['cell_hdr'] if hdr else S['cell']
        # bare code token?
        if re.match(r'^`[^`]+`$', text.strip()):
            return Paragraph(text.strip().strip('`'), S['cell_code'])
        return Paragraph(_xml(text), style)

    data = [
        [_cell(c, hdr=(i == 0)) for c in row]
        for i, row in enumerate(rows)
    ]

    tbl = Table(data, colWidths=[col_w] * col_n, repeatRows=1)
    tbl.setStyle(TableStyle([
        ('BACKGROUND',    (0, 0), (-1,  0), C_HEADER_BG),
        ('FONTNAME',      (0, 0), (-1,  0), 'Helvetica-Bold'),
        ('FONTSIZE',      (0, 0), (-1,  0), 8),
        ('TOPPADDING',    (0, 0), (-1,  0), 5),
        ('BOTTOMPADDING', (0, 0), (-1,  0), 5),
        ('FONTNAME',      (0, 1), (-1, -1), 'Helvetica'),
        ('FONTSIZE',      (0, 1), (-1, -1), 8),
        ('TOPPADDING',    (0, 1), (-1, -1), 4),
        ('BOTTOMPADDING', (0, 1), (-1, -1), 4),
        ('LEFTPADDING',   (0, 0), (-1, -1), 6),
        ('RIGHTPADDING',  (0, 0), (-1, -1), 6),
        ('ROWBACKGROUNDS',(0, 1), (-1, -1), [colors.white, C_ROW_ALT]),
        ('GRID',          (0, 0), (-1, -1), 0.5, C_HR),
        ('VALIGN',        (0, 0), (-1, -1), 'TOP'),
    ]))
    return tbl  # caller (flush_table) wraps in KeepTogether


# ── Step card ─────────────────────────────────────────────────────────────────
def _step_card(number, title, desc_lines):
    """Numbered step card: big red number | bold blue title + description."""
    num_style = ParagraphStyle('step_num',
        fontName='Helvetica-Bold', fontSize=20, leading=24,
        textColor=C_STEP_NUM, alignment=TA_CENTER)
    title_style = ParagraphStyle('step_title',
        fontName='Helvetica-Bold', fontSize=10, leading=13,
        textColor=C_STEP_TITLE)
    desc_style = ParagraphStyle('step_desc',
        fontName='Helvetica', fontSize=9, leading=13,
        textColor=colors.black, spaceBefore=2)

    content = [Paragraph(_xml(title), title_style)]
    if desc_lines:
        desc = ' '.join(l.strip() for l in desc_lines if l.strip())
        if desc:
            content.append(Paragraph(_xml(desc), desc_style))

    data = [[Paragraph(str(number), num_style), content]]
    tbl = Table(data, colWidths=[0.45 * inch, BODY_W - 0.45 * inch])
    tbl.setStyle(TableStyle([
        ('VALIGN',        (0, 0), (-1, -1), 'MIDDLE'),
        ('LEFTPADDING',   (0, 0), (0,  -1), 8),
        ('RIGHTPADDING',  (0, 0), (0,  -1), 4),
        ('LEFTPADDING',   (1, 0), (1,  -1), 10),
        ('RIGHTPADDING',  (1, 0), (1,  -1), 8),
        ('TOPPADDING',    (0, 0), (-1, -1), 7),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 7),
        ('BOX',           (0, 0), (-1, -1), 0.5, C_BOX_BLUE),
        ('LINEBEFORE',    (1, 0), (1,  -1), 0.5, C_HR),
        ('BACKGROUND',    (0, 0), (-1, -1), colors.white),
    ]))
    return [tbl, Spacer(1, 4)]


# ── Mode card ─────────────────────────────────────────────────────────────────
def _mode_card(mode_num, title, body_lines):
    """Colored mode card: dark header strip + white body with Use/Do/Don't/Key."""
    hdr_color = MODE_COLORS.get(mode_num, C_HEADER_BG)
    hdr_style = ParagraphStyle('mode_hdr',
        fontName='Helvetica-Bold', fontSize=10, leading=13,
        textColor=colors.white)
    lbl_style = ParagraphStyle('mode_lbl',
        fontName='Helvetica', fontSize=9, leading=13,
        textColor=colors.black, spaceAfter=2)

    header = Paragraph(f'MODE {mode_num} — {title}', hdr_style)

    body_paras = []
    for ln in body_lines:
        ln = ln.strip()
        if not ln:
            continue
        # **Label:** value  →  bold label + normal value
        m = re.match(r'\*\*(.+?)\*\*:\s*(.*)', ln)
        if m:
            label, value = m.group(1), m.group(2)
            text = f'<b>{label}:</b> {_xml(value)}'
        else:
            text = _xml(ln)
        body_paras.append(Paragraph(text, lbl_style))

    data = [[header], [body_paras if body_paras else [Spacer(1, 0)]]]
    tbl = Table(data, colWidths=[BODY_W])
    tbl.setStyle(TableStyle([
        ('BACKGROUND',    (0, 0), (-1,  0), hdr_color),
        ('BACKGROUND',    (0, 1), (-1, -1), colors.white),
        ('TOPPADDING',    (0, 0), (-1,  0), 6),
        ('BOTTOMPADDING', (0, 0), (-1,  0), 6),
        ('LEFTPADDING',   (0, 0), (-1, -1), 10),
        ('RIGHTPADDING',  (0, 0), (-1, -1), 8),
        ('TOPPADDING',    (0, 1), (-1, -1), 8),
        ('BOTTOMPADDING', (0, 1), (-1, -1), 8),
        ('BOX',           (0, 0), (-1, -1), 0.5, hdr_color),
    ]))
    return [tbl, Spacer(1, 6)]


# ── Callout box ───────────────────────────────────────────────────────────────
def _callout(text, border=None):
    if border is None:
        low = text.lower()
        if any(w in low for w in ['warning', 'important', 'caution', 'never', 'mandatory']):
            border = C_BOX_AMBER
        elif any(w in low for w in ['tip', 'key principle', 'note']):
            border = C_BOX_GREEN
        else:
            border = C_BOX_BLUE
    para = Paragraph(_xml(text), S['callout'])
    tbl  = Table([[para]], colWidths=[BODY_W])
    tbl.setStyle(TableStyle([
        ('BACKGROUND',    (0, 0), (-1, -1), C_BOX_BG),
        ('LINEBEFORE',    (0, 0), (0,  -1), 3, border),
        ('LINEABOVE',     (0, 0), (-1,  0), 0.5, border),
        ('LINEBELOW',     (0,-1), (-1, -1), 0.5, border),
        ('LINEAFTER',     (0, 0), (-1, -1), 0.5, C_HR),
        ('LEFTPADDING',   (0, 0), (-1, -1), 10),
        ('RIGHTPADDING',  (0, 0), (-1, -1), 8),
        ('TOPPADDING',    (0, 0), (-1, -1), 6),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
    ]))
    return [Spacer(1, 4), KeepTogether(tbl), Spacer(1, 6)]


# ── Markdown parser ───────────────────────────────────────────────────────────
def parse_md(md_text):
    """
    Parse the guide markdown into (section_titles, sections).
    section_titles : list[str]   — one per ## heading, for the TOC
    sections       : list[list]  — parallel list of ReportLab flowable lists
    Everything before the first ## heading is skipped (title + editor note).
    """
    lines = md_text.splitlines()
    section_titles = []
    sections       = []
    current        = []          # flowables for the current section

    in_code    = False
    code_lines = []
    tbl_lines  = []

    # Track whether the last content added was a heading (## or ###),
    # so flush_table() can wrap heading + table in a single KeepTogether.
    heading_pending    = [False]
    heading_start_idx  = [0]

    def _reset_heading():
        heading_pending[0]   = False
        heading_start_idx[0] = 0

    def flush_table():
        if not tbl_lines:
            return
        rows = _parse_table_rows(tbl_lines)
        tbl  = _table_flowable(rows)
        if tbl:
            if heading_pending[0]:
                # Wrap heading items + table in one KeepTogether block
                h_items = current[heading_start_idx[0]:]
                del current[heading_start_idx[0]:]
                current.append(KeepTogether(
                    h_items + [Spacer(1, 4), tbl, Spacer(1, 6)]
                ))
            else:
                current.append(Spacer(1, 4))
                current.append(tbl)
                current.append(Spacer(1, 6))
        _reset_heading()
        tbl_lines.clear()

    i = 0
    while i < len(lines):
        line = lines[i]

        # ── code fence ───────────────────────────────────────────────────────
        if line.strip().startswith('```'):
            flush_table()
            if not in_code:
                in_code    = True
                code_lines = []
            else:
                in_code = False
                current.extend(_code_block(code_lines))
                code_lines = []
            i += 1
            continue

        if in_code:
            code_lines.append(line)
            i += 1
            continue

        # ── table row ────────────────────────────────────────────────────────
        if line.strip().startswith('|'):
            tbl_lines.append(line)
            i += 1
            continue
        else:
            flush_table()

        # ── horizontal rule / section separator ──────────────────────────────
        if re.match(r'^[-*_]{3,}\s*$', line.strip()):
            _reset_heading()
            # Only render within a section (skip bare dividers between sections)
            if current:
                current.append(HRFlowable(width=BODY_W, thickness=0.5,
                                           color=C_HR, spaceBefore=4, spaceAfter=4))
            i += 1
            continue

        # ── document title (single #) — skip ─────────────────────────────────
        if re.match(r'^# [^#]', line):
            i += 1
            continue

        # ── section heading (##) ─────────────────────────────────────────────
        if re.match(r'^## ', line):
            title = line[3:].strip()
            section_titles.append(title)
            if current:
                sections.append(current)
            current = []
            heading_start_idx[0] = len(current)
            heading_pending[0]   = True
            current.append(Paragraph(_xml(title), S['h1']))
            current.append(HRFlowable(width=BODY_W, thickness=1,
                                       color=C_NAVY, spaceAfter=5))
            i += 1
            continue

        # ── sub-heading (###) ────────────────────────────────────────────────
        if re.match(r'^### ', line):
            title = line[4:].strip()
            heading_start_idx[0] = len(current)
            heading_pending[0]   = True
            current.append(Paragraph(_xml(title), S['h2']))
            current.append(HRFlowable(width=BODY_W, thickness=0.5,
                                       color=C_HR, spaceAfter=3))
            i += 1
            continue

        # ── mode card (#### MODE N — TITLE) ──────────────────────────────────
        mc = re.match(r'^#### MODE (\d+) — (.+)', line)
        if mc:
            _reset_heading()
            mode_num   = int(mc.group(1))
            mode_title = mc.group(2).strip()
            j = i + 1
            body_lines = []
            while j < len(lines) and lines[j].strip() and not lines[j].startswith('#'):
                body_lines.append(lines[j])
                j += 1
            current.extend(_mode_card(mode_num, mode_title, body_lines))
            i = j
            continue

        # ── step card (#### N. Title) ─────────────────────────────────────────
        sc = re.match(r'^#### (\d+)\.\s+(.+)', line)
        if sc:
            _reset_heading()
            number = sc.group(1)
            title  = sc.group(2).strip()
            j = i + 1
            desc_lines = []
            while j < len(lines) and lines[j].strip() and not lines[j].startswith('#'):
                desc_lines.append(lines[j])
                j += 1
            current.extend(_step_card(number, title, desc_lines))
            i = j
            continue

        # ── blockquote / callout ─────────────────────────────────────────────
        if line.strip().startswith('> '):
            _reset_heading()
            parts = [line.strip()[2:]]
            j = i + 1
            while j < len(lines) and lines[j].strip().startswith('> '):
                parts.append(lines[j].strip()[2:])
                j += 1
            current.extend(_callout(' '.join(parts)))
            i = j
            continue

        # ── bullet list ───────────────────────────────────────────────────────
        m = re.match(r'^(\s*)([-*+])\s+(.*)', line)
        if m:
            _reset_heading()
            indent = len(m.group(1))
            text   = m.group(3)
            style  = S['bullet_sub'] if indent >= 4 else S['bullet']
            bullet_char = '• '
            current.append(Paragraph(bullet_char + _xml(text), style))
            i += 1
            continue

        # ── numbered list ─────────────────────────────────────────────────────
        m = re.match(r'^(\s*)\d+[.)]\s+(.*)', line)
        if m:
            _reset_heading()
            indent = len(m.group(1))
            text   = m.group(2)
            style  = S['bullet_sub'] if indent >= 4 else S['bullet']
            current.append(Paragraph(_xml(text), style))
            i += 1
            continue

        # ── image ─────────────────────────────────────────────────────────────
        m = re.match(r'!\[([^\]]*)\]\(([^)]+)\)', line.strip())
        if m:
            _reset_heading()
            rel_path = m.group(2)
            img = None
            if rel_path.startswith('http://') or rel_path.startswith('https://'):
                try:
                    import urllib.request, tempfile
                    tmp = tempfile.NamedTemporaryFile(suffix='.png', delete=False)
                    urllib.request.urlretrieve(rel_path, tmp.name)
                    tmp.close()
                    img = Image(tmp.name, width=1.5 * inch, height=1.5 * inch)
                except Exception:
                    pass
            else:
                img_path = GUIDE_DIR / rel_path
                if img_path.exists():
                    try:
                        img = Image(str(img_path), width=1.5 * inch, height=1.5 * inch)
                    except Exception:
                        pass
            if img:
                img.hAlign = 'CENTER'
                current.append(Spacer(1, 6))
                current.append(img)
                current.append(Spacer(1, 6))
            i += 1
            continue

        # ── blank line ────────────────────────────────────────────────────────
        if not line.strip():
            i += 1
            continue

        # ── paragraph (accumulate continuation lines) ─────────────────────────
        # Skip pure editor-note lines before any section heading is seen
        if not section_titles:
            i += 1
            continue

        para_lines = [line]
        j = i + 1
        while j < len(lines):
            nxt = lines[j]
            if (not nxt.strip()
                    or nxt.strip().startswith('#')
                    or nxt.strip().startswith('|')
                    or nxt.strip().startswith('```')
                    or nxt.strip().startswith('> ')
                    or re.match(r'^\s*[-*+]\s', nxt)
                    or re.match(r'^\s*\d+[.)]\s', nxt)
                    or re.match(r'^[-*_]{3,}\s*$', nxt.strip())):
                break
            para_lines.append(nxt)
            j += 1

        text = ' '.join(ln.strip() for ln in para_lines).strip()
        if text:
            # Standalone italic line (e.g. *Guide — v1.0*) → centered footer style
            if re.match(r'^\*[^*]+\*$', text):
                current.append(Paragraph(_xml(text), S['footer']))
            else:
                _reset_heading()
                current.append(Paragraph(_xml(text), S['body']))
        i = j

    # flush anything remaining
    flush_table()
    if current:
        sections.append(current)

    return section_titles, sections


# ── Cover page ────────────────────────────────────────────────────────────────
def _cover():
    f = []
    f.append(Spacer(1, 2.2 * inch))
    f.append(Paragraph('Alubys AI Development System', S['cover_title']))
    f.append(Spacer(1, 0.08 * inch))
    f.append(Paragraph('Reference Guide', S['cover_subtitle']))
    f.append(Paragraph('Version 1.0 — May 2026', S['cover_version']))
    f.append(Spacer(1, 1.0 * inch))
    f.append(Paragraph(
        'A reusable AI operating system for project work.', S['cover_desc']))
    f.append(Paragraph(
        'Persistent memory, structured workflows, and session protocols', S['cover_desc']))
    f.append(Paragraph(
        'that let any AI work on your project with full context, every session.',
        S['cover_desc']))
    f.append(Spacer(1, 1.8 * inch))
    f.append(Paragraph(
        'github.com/AlubysLLC/Alubys-AI-Dev-System — v1.0 — May 2026',
        S['cover_footer']))
    return f


# ── TOC page ──────────────────────────────────────────────────────────────────
def _toc(titles):
    f = []
    f.append(Paragraph('Contents', S['toc_heading']))
    f.append(HRFlowable(width=BODY_W, thickness=1, color=C_NAVY, spaceAfter=10))
    for t in titles:
        f.append(Paragraph(t, S['toc_entry']))
    return f


# ── Document assembly ─────────────────────────────────────────────────────────
def main():
    if not SOURCE_MD.exists():
        print(f'ERROR: Source not found: {SOURCE_MD}')
        sys.exit(1)

    print(f'Reading:  {SOURCE_MD}')
    md_text = SOURCE_MD.read_text(encoding='utf-8')

    section_titles, sections = parse_md(md_text)
    print(f'Sections: {len(sections)}')

    # Page templates
    cover_frame = Frame(M_LEFT, M_BOTTOM, BODY_W, COVER_FRAME_H,
                        id='cover', showBoundary=0)
    body_frame  = Frame(M_LEFT, M_BOTTOM, BODY_W, BODY_FRAME_H,
                        id='body',  showBoundary=0)

    cover_tpl = PageTemplate(id='cover', frames=[cover_frame])
    body_tpl  = PageTemplate(id='body',  frames=[body_frame])

    doc = BaseDocTemplate(
        str(OUTPUT_PDF),
        pagesize=letter,
        pageTemplates=[cover_tpl, body_tpl],
        leftMargin=M_LEFT, rightMargin=M_RIGHT,
        topMargin=M_TOP,   bottomMargin=M_BOTTOM,
    )

    story = []

    # Page 1 — cover
    story.extend(_cover())
    story.append(NextPageTemplate('body'))
    story.append(PageBreak())

    # Page 2 — TOC
    story.extend(_toc(section_titles))
    story.append(PageBreak())

    # Pages 3+ — sections, each on its own page
    for idx, flowables in enumerate(sections):
        if idx > 0:
            story.append(PageBreak())
        story.extend(flowables)

    doc.build(story, canvasmaker=HeaderCanvas)
    print(f'Output:   {OUTPUT_PDF}')


if __name__ == '__main__':
    main()
