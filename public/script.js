const yesBtn = document.getElementById("yesBtn");
const noBtn = document.getElementById("noBtn");
const output = document.getElementById("output");

yesBtn.addEventListener("click", () => {
    output.textContent = "Nganung ge YES man nimo? Naman kay meeting ron";
});

noBtn.addEventListener("click", () => {
    output.textContent = "Nganung ge NO man nimo? Manghinlo gihapon ta ron!";
});