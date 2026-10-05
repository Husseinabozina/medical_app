(() => {
  const screens = {
    home: {
      number: '01',
      title: 'Home',
      flow: 'Discovery',
      route: '/home',
      image: 'docs/assets/app-screens/01-home.png',
      alt: 'HealthTrack home interface',
      avatars: [{ left: '84.2%', top: '6.2%', size: '8.5%' }],
      copy: 'The main HealthTrack entry point with quick access, upcoming care and doctor discovery.'
    },
    specialties: {
      number: '02',
      title: 'Specialties',
      flow: 'Browse care',
      route: '/specialties',
      image: 'docs/assets/app-screens/02-specialties.png',
      alt: 'HealthTrack specialties interface',
      copy: 'A clear specialty directory that branches into the implemented doctor-list journeys.'
    },
    doctors: {
      number: '03',
      title: 'Doctors',
      flow: 'Discovery',
      route: '/doctors',
      image: 'docs/assets/app-screens/03-doctors.png',
      alt: 'HealthTrack doctors interface',
      avatars: [
        { left: '12.4%', top: '44.7%', size: '20.2%' },
        { left: '12.4%', top: '58.8%', size: '20.2%' },
        { left: '12.4%', top: '73.2%', size: '20.2%' },
        { left: '12.4%', top: '87.7%', size: '20.2%' }
      ],
      copy: 'Doctor discovery with search, filters, cards and favorite state connected to the wider app flow.'
    },
    profile: {
      number: '04',
      title: 'Doctor profile',
      flow: 'Doctor details',
      route: '/doctor/emma/profile',
      image: 'docs/assets/app-screens/04-doctor-profile.png',
      alt: 'HealthTrack doctor profile interface',
      avatars: [{ left: '14.4%', top: '15.4%', size: '30.6%' }],
      copy: 'A detailed doctor view that keeps the path from discovery into booking focused and readable.'
    },
    schedule: {
      number: '05',
      title: 'Schedule',
      flow: 'Booking',
      route: '/doctor/emma/schedule',
      image: 'docs/assets/app-screens/05-schedule.png',
      alt: 'HealthTrack appointment scheduling interface',
      copy: 'Date and time selection before continuing through payment and appointment confirmation.'
    },
    appointment: {
      number: '06',
      title: 'Appointment details',
      flow: 'Follow-up',
      route: '/appointments/details',
      image: 'docs/assets/app-screens/06-appointment-details.png',
      alt: 'HealthTrack appointment details interface',
      avatars: [{ left: '13.4%', top: '14.3%', size: '19.2%' }],
      copy: 'Appointment information and actions connected to cancellation, review and follow-up states.'
    },
    record: {
      number: '07',
      title: 'Medical record',
      flow: 'Health records',
      route: '/medical-record/menu',
      image: 'docs/assets/app-screens/07-medical-record.png',
      alt: 'HealthTrack medical record interface',
      copy: 'A structured entry point for allergies, analysis, vaccinations and medical history.'
    },
    payment: {
      number: '08',
      title: 'Payment summary',
      flow: 'Checkout',
      route: '/payment/summary',
      image: 'docs/assets/app-screens/08-payment-summary.png',
      alt: 'HealthTrack payment summary interface',
      avatars: [{ left: '7.8%', top: '29.7%', size: '23.8%' }],
      copy: 'The review step before the showcase payment success state and appointment confirmation.'
    }
  };

  const image = document.querySelector('#app-screen-image');
  const indicator = document.querySelector('#screen-swap-indicator');
  const avatarOverlays = document.querySelector('#avatar-overlays');
  const number = document.querySelector('#screen-number');
  const title = document.querySelector('#screen-title');
  const flow = document.querySelector('#screen-flow');
  const route = document.querySelector('#screen-route');
  const copy = document.querySelector('#screen-copy');
  const tabs = [...document.querySelectorAll('.screen-tab')];

  function selectScreen(key) {
    const screen = screens[key];
    if (!screen || !image) return;

    tabs.forEach((tab) => tab.classList.toggle('is-active', tab.dataset.screen === key));

    number.textContent = screen.number;
    title.textContent = screen.title;
    flow.textContent = screen.flow;
    route.textContent = screen.route;
    copy.textContent = screen.copy;

    if (avatarOverlays) {
      avatarOverlays.classList.add('is-changing');
      avatarOverlays.replaceChildren();
      (screen.avatars ?? []).forEach((avatar) => {
        const mask = document.createElement('img');
        mask.src = 'docs/assets/doctor-avatar.svg';
        mask.alt = '';
        mask.style.setProperty('--avatar-left', avatar.left);
        mask.style.setProperty('--avatar-top', avatar.top);
        mask.style.setProperty('--avatar-size', avatar.size);
        avatarOverlays.appendChild(mask);
      });
      window.requestAnimationFrame(() => avatarOverlays.classList.remove('is-changing'));
    }

    image.classList.add('is-changing');
    indicator?.classList.add('is-visible');

    const next = new Image();
    next.src = screen.image;
    next.alt = screen.alt;

    next.onload = () => {
      image.src = screen.image;
      image.alt = screen.alt;
      image.classList.remove('is-changing');
      indicator?.classList.remove('is-visible');
    };

    next.onerror = () => {
      image.classList.remove('is-changing');
      indicator?.classList.remove('is-visible');
    };
  }

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => selectScreen(tab.dataset.screen));
  });

  selectScreen('home');

  Object.values(screens).slice(1).forEach((screen) => {
    const preload = new Image();
    preload.src = screen.image;
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