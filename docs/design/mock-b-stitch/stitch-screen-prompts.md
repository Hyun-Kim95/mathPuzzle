# Stitch Screen Prompts (copy into `generate_screen_from_text`)

**Shared constraints (append to every prompt):**

```text
Platform: mobile portrait 390x844.
Language: English UI labels.
States: show default UI; include loading on primary CTA where relevant.
Accessibility: 44pt touch targets, text/background contrast WCAG AA.
Dark mode: support light and dark theme variants.
No login. Minimal decoration. Match design system Playful Logic.
```

---

## 1. Level select (S04) — chapters

```text
Goal: Level map for a math pattern puzzle game with 100 levels grouped in chapters.
User: casual puzzle player returning to pick a level.
Layout: Top gradient hero header with app title "Pattern Quest", subtitle "Chapter 1 · 3/100 cleared", settings gear icon.
Below: scrollable sections "Chapter 1 · Levels 1-20" with rounded chip buttons in rows.
Chip states: completed green check, perfect gold star, current level purple outline, locked gray padlock.
Second section "Chapter 2" mostly locked chips.
Bottom: slim banner ad placeholder (labeled).
Style: playful violet-to-cyan gradient header, soft card shadows, friendly game UI.
```

---

## 2. Puzzle play (S05)

```text
Goal: Single puzzle screen — find missing number in 3x3 grid.
Header: gradient bar "Level 4", subtitle "Find the missing number", back arrow left.
Center card: 3x3 number grid, bottom-right cell shows "?" highlighted.
Large numeric input, pill-shaped primary button "Submit".
Two secondary pill buttons: "Hint" and "Answer" with icons.
Optional collapsed hint panel area below buttons.
Style: same design system, focus on readability, large tap targets.
```

---

## 3. Level complete (S06)

```text
Goal: Success feedback after correct answer.
Center: celebration emoji, headline "Level cleared!", subcopy for perfect star if applicable.
Primary CTA "Next level", secondary "Back to levels".
Style: uplifting, consistent with puzzle screen gradients.
```

---

## 4. Settings (S08)

```text
Goal: Settings list for offline puzzle game.
Rows: Mute all, Music toggle, Sound effects toggle, Contact us, Support developer, Privacy policy, Terms, About, Reset progress (destructive red text).
iOS-style list with chevrons on navigation rows, toggles on sound rows.
Style: clean list on light surface, gradient accent on header only.
```

---

## 5. Rewarded ad modal (overlay)

```text
Goal: Modal dialog before showing rewarded video to unlock hint.
Center card on dimmed overlay: film icon, title "Unlock hint", body "Watch a short video to continue."
Primary "Watch video", secondary "Not now".
Style: rounded 24px modal, friendly not aggressive.
```

---

## 6. Splash (S01)

```text
Goal: App launch splash.
Center: abstract math symbol logo on gradient circle, app name "Math Pattern Puzzle", tagline "Find the rule. Fill the blank."
Minimal, fast-read, brand moment.
```
