const phone = document.getElementById("phone");
const screens = document.querySelectorAll(".screen");
const select = document.getElementById("screenSelect");

function showScreen(id) {
  screens.forEach((s) => s.classList.toggle("active", s.dataset.screen === id));
  if (select) select.value = id;
}

if (select) select.addEventListener("change", () => showScreen(select.value));

document.querySelectorAll("[data-goto]").forEach((el) => {
  el.addEventListener("click", () => showScreen(el.dataset.goto));
});

const darkToggle = document.getElementById("darkToggle");
if (darkToggle) {
  darkToggle.addEventListener("change", (e) => {
    phone.dataset.theme = e.target.checked ? "dark" : "light";
  });
}

const adModal = document.getElementById("adModal");
document.getElementById("showAdModal")?.addEventListener("click", () => adModal?.classList.add("show"));
document.getElementById("closeAd")?.addEventListener("click", () => adModal?.classList.remove("show"));

document.getElementById("showHint")?.addEventListener("click", () => {
  showScreen("puzzle");
  const hint = document.getElementById("hintPanel");
  if (hint) hint.hidden = false;
});

const grid = document.getElementById("levelGrid");
if (grid) {
  for (let i = 1; i <= 20; i++) {
    const cell = document.createElement("button");
    cell.type = "button";
    cell.className = "level-cell";
    if (i === 3) cell.textContent = "\u26053";
    else if (i < 3) cell.textContent = "\u2713" + i;
    else if (i === 4) cell.textContent = String(i);
    else cell.textContent = "\u{1F512}";
    if (i < 3) cell.classList.add("done");
    if (i === 3) cell.classList.add("perfect");
    if (i === 4) cell.classList.add("current");
    if (i > 4) cell.classList.add("locked");
    if (i === 4) cell.addEventListener("click", () => showScreen("puzzle"));
    grid.appendChild(cell);
  }
}

document.querySelectorAll(".toggle").forEach((t) => {
  t.addEventListener("click", () => t.classList.toggle("on"));
});
