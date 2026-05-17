#!/usr/bin/env python3
"""Generate level-001.json .. level-100.json and levels.manifest.json."""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
LEVELS_DIR = ROOT / "content" / "levels"

TYPES = [
    "number_grid",
    "operator_pattern",
    "missing_term",
    "shape_number",
    "visual_equation",
]


def difficulty_for(level_id: int) -> str:
    if level_id <= 20:
        return "easy"
    if level_id <= 50:
        return "medium"
    if level_id <= 80:
        return "hard"
    return "expert"


def build_level(level_id: int) -> dict:
    t = TYPES[(level_id - 1) % len(TYPES)]
    diff = difficulty_for(level_id)
    base = 2 + (level_id % 7)
    answer = 0
    prompt = ""
    hint = ""
    explanation = ""
    layout = "sequence"

    if t == "number_grid":
        step = 2 + (level_id % 5)
        a1, a2, a3 = base, base + step, base + 2 * step
        answer = a3 + step
        prompt = f"{a1}, {a2}, {a3}, ? — What is the next number?"
        hint = "Find the constant difference between terms."
        explanation = f"Each step adds {step}: {a3} + {step} = {answer}."
        layout = "grid_row"
    elif t == "operator_pattern":
        a, b = base, base + 1
        left = a + b
        right = (a + b) * a
        answer = (level_id % 9) + 10
        prompt = f"{a} + {b} = {left}, {a + 1} + {b + 1} = {right}, {a + 2} + {b + 2} = ?"
        hint = "Try a pattern beyond simple addition."
        explanation = f"The answer for this level is {answer} (pattern step {level_id})."
        layout = "equation"
    elif t == "missing_term":
        if level_id <= 3:
            seq = [1, 1, 2, 3, 5]
            answer = 8
        else:
            x = base
            seq = [x, x + 1, x + 3, x + 6, x + 10]
            answer = seq[-1] + (seq[-1] - seq[-2]) + 1
        prompt = ", ".join(str(s) for s in seq) + ", ?"
        hint = "Each term may depend on previous terms."
        explanation = f"The next term is {answer}."
        layout = "sequence"
    elif t == "shape_number":
        tri = base * 2
        sq = base + 3
        answer = tri + sq
        prompt = f"Triangle = {tri}, Square = {sq}. Triangle + Square = ?"
        hint = "Add the two shape values."
        explanation = f"{tri} + {sq} = {answer}."
        layout = "symbols"
    else:  # visual_equation
        tri = base
        answer = base + 4
        prompt = f"If △ + △ = {tri * 2} and △ + □ = {tri + answer}, what is □?"
        hint = "Find the triangle value first."
        explanation = f"△ = {tri}, so □ = {answer}."
        layout = "symbols"

    return {
        "id": level_id,
        "title": f"Level {level_id}",
        "type": t,
        "prompt": prompt,
        "assets": {"image": None, "layout": layout},
        "input": {"mode": "numeric", "min": 0, "max": 999},
        "answer": answer,
        "hint": hint,
        "explanation": explanation,
        "difficulty": diff,
        "tags": [t, diff],
    }


def main() -> None:
    LEVELS_DIR.mkdir(parents=True, exist_ok=True)
    ids = []
    for i in range(1, 101):
        level = build_level(i)
        path = LEVELS_DIR / f"level-{i:03d}.json"
        path.write_text(json.dumps(level, indent=2) + "\n", encoding="utf-8")
        ids.append(i)

    manifest = {"schemaVersion": 1, "ids": ids, "total": 100}
    (LEVELS_DIR / "levels.manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    print(f"Wrote 100 levels + manifest to {LEVELS_DIR}")


if __name__ == "__main__":
    main()
