# AGENTS.md

## Purpose

This environment is intended for document extraction, analysis and transformation.

## General Principle

Extraction first.
Structure second.
Analysis third.
Summarization last.

## Analysis Workflow

1. Extract content.
2. Preserve document structure.
3. Convert content to Markdown.
4. Analyze content.
5. Summarize findings.
6. Provide recommendations if requested.

Do not summarize before extraction and structuring are complete.

## Data Integrity Rules

- Never fabricate document contents.
- Distinguish extracted facts from interpretations.
- Report uncertainty explicitly.
- Explain extraction limitations when encountered.
- If content cannot be extracted reliably, state this before performing analysis.

## Tables

- Preserve row and column relationships.
- Preserve header rows.
- Preserve worksheet names for Excel files.
- Keep tables as tables whenever possible.
- Do not flatten tables into paragraphs unless explicitly requested.

## File Handling

- Use the provided document libraries.
- Do not parse Office file formats manually.
- Do not edit ZIP/XML contents directly.
- Do not modify source documents unless explicitly requested.
- Prefer writing results to new files.

## Available Tooling

### PDF

Use PyMuPDF.

- Extract page-by-page.
- Preserve page boundaries when relevant.
- Convert extracted content to Markdown.

### DOCX

Use Mammoth.

- Convert to Markdown.
- Preserve headings, lists, links and tables.

Use python-docx only when low-level document access or editing is required.

### XLSX

Use openpyxl and/or pandas.

- Preserve workbook structure.
- Preserve worksheet names.
- Preserve column names.
- Represent tabular data as Markdown tables.

## Expected Output

### Document Analysis

- Extract faithfully.
- Preserve structure.
- Preserve headings.
- Preserve tables.
- Preserve worksheet boundaries.
- Convert to Markdown.
- Analyze only after extraction is complete.

### Summary Tasks

- Base summaries exclusively on extracted content.
- Do not invent missing information.
- Clearly identify assumptions.

### Comparison Tasks

- Extract each document independently.
- Normalize structure using Markdown.
- Compare facts only after extraction is complete.