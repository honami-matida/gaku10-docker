document.addEventListener("DOMContentLoaded", () => {
  const wrapper = document.querySelector(".wrapper");
  const illustration = document.querySelector(".illustration-area");
  const textBlocks = document.querySelectorAll(".text-block");

  if (!wrapper || !illustration) return;

  const wrapperTop = wrapper.offsetTop;
  const wrapperBottom = wrapperTop + wrapper.offsetHeight;

  window.addEventListener("scroll", () => {

    const scroll = window.scrollY;
    const mid = scroll + window.innerHeight / 2;  // ← ★ここで必ず先に定義！

    // ===== 画像固定 =====
    if (mid >= wrapperTop && mid <= wrapperBottom) {
      illustration.classList.add("fixed");
    } else {
      illustration.classList.remove("fixed");
    }

    // ===== 文字切り替え（位置を正確に計算）=====
    textBlocks.forEach(block => {
      const rect = block.getBoundingClientRect();
      const blockMid = rect.top + rect.height / 2;

      if (blockMid >= window.innerHeight * 0.3 &&
          blockMid <= window.innerHeight * 0.7) {
        textBlocks.forEach(b => b.classList.remove("active"));
        block.classList.add("active");
      }
    });
  });
});