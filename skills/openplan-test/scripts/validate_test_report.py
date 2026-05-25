#!/usr/bin/env python3
import re
import sys
from pathlib import Path


def fail(message: str) -> int:
    print(f"INVALID: {message}", file=sys.stderr)
    return 1


def main() -> int:
    if len(sys.argv) != 2:
        return fail("usage: validate_test_report.py <report.md>")

    path = Path(sys.argv[1])
    if not path.is_file():
        return fail(f"not a file: {path}")

    text = path.read_text(encoding="utf-8")

    if "BLOCKED:" in text:
        for required in ("Missing evidence", "Why it matters", "Next safe step"):
            if required not in text:
                return fail(f"blocked report missing {required}")
        print("VALID")
        return 0

    required_sections = [
        "Test Evidence",
        "Sources Reviewed",
        "Selected Test Layers",
        "Test Map",
        "Regression Proof",
        "Checks Run",
        "Checks Skipped",
        "Human Decisions Required",
        "Residual Risk",
    ]
    for section in required_sections:
        if re.search(rf"^##\s+{re.escape(section)}\b", text, re.M) is None:
            return fail(f"missing section: {section}")

    approval_claims = r"\b(approved|lgtm|safe to merge|fully tested|guaranteed)\b|已批准|可合并|可以合并|安全合并|完全测试|无风险|保证"
    if re.search(approval_claims, text, re.I):
        return fail("avoid approval or guarantee language")

    if "Proven or provisional:" not in text:
        return fail("regression proof must state proven or provisional")

    print("VALID")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
