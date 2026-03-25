// ── Smooth scroll for nav links ──
document.querySelectorAll('a[href^="#"]').forEach(link => {
  link.addEventListener('click', e => {
    e.preventDefault();
    const target = document.querySelector(link.getAttribute('href'));
    if (target) target.scrollIntoView({ behavior: 'smooth' });
  });
});

// ── Fade-in on scroll ──
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('fade-in');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('section').forEach(s => {
  s.style.opacity = '0';
  observer.observe(s);
});

// ── Active nav link highlight ──
window.addEventListener('scroll', () => {
  const sections = document.querySelectorAll('section[id]');
  const links = document.querySelectorAll('nav a');
  let current = '';
  sections.forEach(s => {
    if (window.scrollY >= s.offsetTop - 100) current = s.id;
  });
  links.forEach(a => {
    a.classList.toggle('active', a.getAttribute('href') === '#' + current);
  });
});

console.log('DZONYX loaded.');
