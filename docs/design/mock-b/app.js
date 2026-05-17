const phone = document.getElementById("phone");
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
    b.textContent = i === 3 ? "\u2605" + i : i < 3 ? "\u2713" + i : i === 4 ? String(i) : "\u{1F512}";
    if (i === 4) b.onclick = () => show("puzzle");
    chips.appendChild(b);
  }
}
