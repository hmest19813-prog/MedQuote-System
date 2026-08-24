const CACHE = 'hayat-v2';
const SHELL = ['/', '/index.html', '/manifest.json', '/Hayat logo.png',
  '/lib/react.min.js', '/lib/react-dom.min.js', '/lib/supabase.js', '/lib/babel.min.js'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(caches.keys().then(keys =>
    Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
  ).then(() => self.clients.claim()));
});

/* Network-first: نجيب أحدث نسخة من السيرفر دايماً وقت الاتصال، ونحدّث الكاش
   بالخلفية. الكاش يُستخدم فقط لو النت مقطوع (fallback) — مو كل مرة زي قبل،
   لأن ذاك كان يخبّي أي تعديل جديد على index.html عن المستخدم حتى بعد Hard Refresh. */
self.addEventListener('fetch', e => {
  if (e.request.method !== 'GET') return;
  if (e.request.url.includes('supabase.co')) return; // لا نكش API calls

  e.respondWith(
    fetch(e.request).then(res => {
      if (res.ok && e.request.url.startsWith(self.location.origin)) {
        const clone = res.clone();
        caches.open(CACHE).then(c => c.put(e.request, clone));
      }
      return res;
    }).catch(() => caches.match(e.request))
  );
});
