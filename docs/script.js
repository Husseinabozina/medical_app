(() => {
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  const targets = document.querySelectorAll('.feature-card, .screen-grid figure, .engineering-card');

  if (!reduceMotion && 'IntersectionObserver' in window) {
    targets.forEach((node) => node.classList.add('reveal'));
    const observer = new IntersectionObserver((entries, currentObserver) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          currentObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });

    targets.forEach((node) => observer.observe(node));
  }
})();