(() => {
  const fileKey = 'jrf18b58l0rdFM4uTN5DEg';
  const fileName = 'Medical-App-UI-Kit-Health-Mobile-App-Tracker-Appointment-Mobile-App--Community-';

  const screens = {
    home: {
      number: '01',
      title: 'Home',
      node: '2213:326',
      nodeUrl: '2213-326',
      copy: 'The main HealthTrack entry point with quick access, upcoming care and doctor discovery.'
    },
    specialties: {
      number: '02',
      title: 'Specialties',
      node: '2068:756',
      nodeUrl: '2068-756',
      copy: 'The specialty directory that branches into the eight implemented doctor-list variants.'
    },
    doctors: {
      number: '03',
      title: 'Doctors',
      node: '2068:376',
      nodeUrl: '2068-376',
      copy: 'Doctor discovery with search, filtering, cards and favorite state connected to the broader flow.'
    },
    profile: {
      number: '04',
      title: 'Doctor profile',
      node: '2097:1242',
      nodeUrl: '2097-1242',
      copy: 'A fuller doctor view that keeps the path from discovery into booking clear and focused.'
    },
    schedule: {
      number: '05',
      title: 'Schedule',
      node: '2088:1073',
      nodeUrl: '2088-1073',
      copy: 'Date and time selection with stateful booking choices before continuing to payment.'
    },
    appointment: {
      number: '06',
      title: 'Appointment details',
      node: '2088:1187',
      nodeUrl: '2088-1187',
      copy: 'Appointment information and actions connected to cancel, review and follow-up journeys.'
    },
    record: {
      number: '07',
      title: 'Medical record',
      node: '2110:221',
      nodeUrl: '2110-221',
      copy: 'A structured entry point for allergies, analysis, vaccinations and medical history.'
    },
    payment: {
      number: '08',
      title: 'Payment summary',
      node: '2128:1624',
      nodeUrl: '2128-1624',
      copy: 'The review step before the showcase payment success state and appointment confirmation.'
    }
  };

  const frame = document.querySelector('#figma-frame');
  const loading = document.querySelector('#figma-loading');
  const number = document.querySelector('#screen-number');
  const title = document.querySelector('#screen-title');
  const node = document.querySelector('#screen-node');
  const copy = document.querySelector('#screen-copy');
  const figmaLink = document.querySelector('#figma-link');
  const tabs = [...document.querySelectorAll('.screen-tab')];

  function embedUrl(screen) {
    return `https://embed.figma.com/design/${fileKey}/${fileName}?embed-host=healthtrack-showcase&node-id=${screen.nodeUrl}&footer=false&page-selector=false&viewport-controls=false&theme=light`;
  }

  function sourceUrl(screen) {
    return `https://www.figma.com/design/${fileKey}/${fileName}?node-id=${screen.nodeUrl}&m=dev`;
  }

  function selectScreen(key) {
    const screen = screens[key];
    if (!screen || !frame) return;

    tabs.forEach((tab) => {
      tab.classList.toggle('is-active', tab.dataset.screen === key);
    });

    loading?.classList.remove('is-hidden');
    frame.src = embedUrl(screen);

    if (number) number.textContent = screen.number;
    if (title) title.textContent = screen.title;
    if (node) node.textContent = screen.node;
    if (copy) copy.textContent = screen.copy;
    if (figmaLink) figmaLink.href = sourceUrl(screen);
  }

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => selectScreen(tab.dataset.screen));
  });

  frame?.addEventListener('load', () => {
    window.setTimeout(() => loading?.classList.add('is-hidden'), 500);
  });

  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  const revealItems = document.querySelectorAll(
    '.journey-card, .coverage-card, .engineering-bento article, .architecture-node'
  );

  if (!reduceMotion && 'IntersectionObserver' in window) {
    revealItems.forEach((item) => item.classList.add('reveal'));
    const observer = new IntersectionObserver((entries, currentObserver) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        entry.target.classList.add('is-visible');
        currentObserver.unobserve(entry.target);
      });
    }, { threshold: 0.14 });

    revealItems.forEach((item) => observer.observe(item));
  }
})();