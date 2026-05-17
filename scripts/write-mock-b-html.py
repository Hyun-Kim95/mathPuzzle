from pathlib import Path

# Option B — Playful Gradient (Stitch-direction local preview)
CSS = Path(__file__).resolve().parents[1] / "docs" / "design" / "mock-b" / "styles.css"
HTML_OUT = Path(__file__).resolve().parents[1] / "docs" / "design" / "mock-b" / "index.html"

CSS.write_text(
    """/* Option B — Playful Gradient (Stitch direction preview) */
:root {
  --bg: linear-gradient(165deg, #fff8f0 0%, #f0f4ff 100%);
  --surface: #ffffff;
  --primary: #7c3aed;
  --primary2: #06b6d4;
  --text: #1f2937;
  --muted: #64748b;
  --success: #10b981;
  --radius: 20px;
  --font: "Segoe UI", system-ui, sans-serif;
}
[data-theme="dark"] {
  --bg: linear-gradient(165deg, #1a1025 0%, #0f172a 100%);
  --surface: #1e293b;
  --text: #f1f5f9;
  --muted: #94a3b8;
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: var(--font);
  background: #0f0a1a;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 24px 16px;
}
.toolbar { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 16px; justify-content: center; }
.toolbar select, .toolbar button {
  padding: 8px 12px; border-radius: 999px; border: none;
  background: #312e81; color: #fff; cursor: pointer; font: inherit;
}
.phone {
  width: 390px; height: 844px;
  background: var(--bg);
  border-radius: 44px;
  border: 10px solid #312e81;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  box-shadow: 0 32px 64px rgba(124,58,237,.35);
}
.hero-header {
  padding: 48px 20px 16px;
  background: linear-gradient(135deg, #7c3aed, #06b6d4);
  color: #fff;
  border-radius: 0 0 28px 28px;
}
.hero-header h1 { font-size: 22px; font-weight: 700; }
.hero-header p { opacity: .9; font-size: 14px; margin-top: 4px; }
.screen { flex: 1; display: none; flex-direction: column; overflow: auto; }
.screen.active { display: flex; }
.chapter { padding: 16px; }
.chapter h2 { font-size: 14px; color: var(--muted); margin-bottom: 10px; text-transform: uppercase; letter-spacing: .06em; }
.level-row { display: flex; gap: 8px; flex-wrap: wrap; }
.chip {
  min-width: 52px; height: 52px; border-radius: 16px;
  border: none; font-weight: 700; font-size: 15px;
  background: var(--surface); color: var(--text);
  box-shadow: 0 4px 12px rgba(0,0,0,.08);
  cursor: pointer;
}
.chip.done { background: #d1fae5; color: #065f46; }
.chip.star { background: linear-gradient(135deg, #fde68a, #fbbf24); color: #78350f; }
.chip.lock { opacity: .45; }
.chip.now { outline: 3px solid #7c3aed; }
.card {
  margin: 16px; padding: 20px;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: 0 8px 24px rgba(0,0,0,.06);
}
.puzzle-grid {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin: 16px 0;
}
.puzzle-grid span {
  padding: 16px; text-align: center; font-weight: 700; font-size: 20px;
  background: #f1f5f9; border-radius: 14px;
}
[data-theme="dark"] .puzzle-grid span { background: #334155; }
.puzzle-grid .q {
  background: linear-gradient(135deg, #ede9fe, #cffafe);
  color: #5b21b6;
}
input {
  width: 100%; padding: 16px; font-size: 18px; border: 2px solid #e2e8f0;
  border-radius: 14px; margin-bottom: 12px;
}
.btn {
  width: 100%; padding: 16px; border: none; border-radius: 999px;
  font-size: 16px; font-weight: 700; cursor: pointer; margin-bottom: 10px;
}
.btn-main {
  background: linear-gradient(90deg, #7c3aed, #06b6d4);
  color: #fff;
}
.btn-soft { background: #f1f5f9; color: #7c3aed; }
.row { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.fab-settings {
  position: absolute; right: 20px; top: 52px;
  width: 44px; height: 44px; border-radius: 50%;
  border: none; background: rgba(255,255,255,.25);
  color: #fff; font-size: 20px; cursor: pointer;
}
.modal-overlay {
  display: none; position: absolute; inset: 0;
  background: rgba(15,10,26,.6); align-items: center; justify-content: center; padding: 24px;
}
.modal-overlay.show { display: flex; }
.modal {
  background: var(--surface); border-radius: 24px; padding: 28px; text-align: center; width: 100%;
}
.modal .icon { font-size: 40px; margin-bottom: 12px; }
.caption { color: #94a3b8; font-size: 12px; margin-top: 12px; text-align: center; max-width: 390px; }
""",
    encoding="utf-8",
)

HTML = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Math Pattern Puzzle — Design B (Stitch)</title>
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <div class="toolbar">
    <select id="screenSelect">
      <option value="levels">S04 Levels (chapters)</option>
      <option value="puzzle">S05 Puzzle</option>
      <option value="complete">S06 Complete</option>
      <option value="modal">Ad modal</option>
    </select>
    <button type="button" id="darkToggle">Toggle dark</button>
  </div>
  <div class="phone" id="phone" data-theme="light" style="position:relative">
    <section class="screen levels active" data-screen="levels">
      <div class="hero-header">
        <button type="button" class="fab-settings" title="Settings">&#9881;</button>
        <h1>Pattern Quest</h1>
        <p>Chapter 1 · 3 / 100 cleared</p>
      </div>
      <div class="chapter">
        <h2>Chapter 1 · Levels 1-20</h2>
        <div class="level-row" id="chips"></motion>
      </motion>
      <div class="chapter">
        <h2>Chapter 2 · Levels 21-40</h2>
        <div class="level-row">
          <button type="button" class="chip lock">&#128274;</button>
        </motion>
      </motion>
    </section>
    <section class="screen" data-screen="puzzle">
      <motion class="hero-header" style="padding-top:44px">
        <h1>Level 4</h1>
        <p>Find the missing number</p>
      </motion>
      <div class="card">
        <div class="puzzle-grid">
          <span>8</span><span>1</span><span>6</span>
          <span>3</span><span>5</span><span>7</span>
          <span>4</span><span>9</span><span class="q">?</span>
        </motion>
        <input type="number" placeholder="?" />
        <button type="button" class="btn btn-main">Submit</button>
        <div class="row">
          <button type="button" class="btn btn-soft">&#128161; Hint</button>
          <button type="button" class="btn btn-soft">Answer</button>
        </motion>
      </motion>
    </section>
    <section class="screen" data-screen="complete">
      <div class="card" style="margin-top:120px;text-align:center">
        <p style="font-size:56px">&#127881;</p>
        <h2 style="margin:12px 0">Level cleared!</h2>
        <button type="button" class="btn btn-main">Next level</button>
      </motion>
    </section>
    <div class="modal-overlay show" data-screen="modal" id="adModal" style="display:none">
      <div class="modal">
        <p class="icon">&#127916;</p>
        <h2>Unlock hint</h2>
        <p style="color:var(--muted);margin:12px 0 20px">Watch a short video to continue.</p>
        <button type="button" class="btn btn-main">Watch video</button>
        <button type="button" class="btn btn-soft" id="closeAd">Not now</button>
      </motion>
    </motion>
  </motion>
  <p class="caption"><strong>Option B</strong> — Stitch-direction preview (local). Final: Stitch project screens.</p>
  <script src="app.js"></script>
</body>
</html>
"""

TAG = "motion"
HTML = HTML.replace("<" + TAG + " ", "<div ").replace("</" + TAG + ">", "</div>")

HTML_OUT.write_text(HTML, encoding="utf-8")
assert "<motion" not in HTML

JS = Path(__file__).resolve().parents[1] / "docs" / "design" / "mock-b" / "app.js"
JS.write_text(
    """const phone = document.getElementById("phone");
const screens = document.querySelectorAll(".screen, .modal-overlay[data-screen]");
const select = document.getElementById("screenSelect");
function show(id) {
  document.querySelectorAll(".screen").forEach(s => s.classList.toggle("active", s.dataset.screen === id));
  const modal = document.getElementById("adModal");
  if (modal) modal.style.display = id === "modal" ? "flex" : "none";
  if (select && id !== "modal") select.value = id;
}
select?.addEventListener("change", () => show(select.value));
document.getElementById("darkToggle")?.addEventListener("click", () => {
  phone.dataset.theme = phone.dataset.theme === "dark" ? "light" : "dark";
});
document.getElementById("closeAd")?.addEventListener("click", () => show("puzzle"));
const chips = document.getElementById("chips");
if (chips) {
  for (let i = 1; i <= 8; i++) {
    const b = document.createElement("button");
    b.type = "button";
    b.className = "chip" + (i < 3 ? " done" : i === 3 ? " star" : i === 4 ? " now" : " lock");
    b.textContent = i === 3 ? "\\u2605" + i : i < 3 ? "\\u2713" + i : i === 4 ? String(i) : "\\u{1F512}";
    if (i === 4) b.onclick = () => show("puzzle");
    chips.appendChild(b);
  }
}
""",
    encoding="utf-8",
)
print("OK mock-b")
