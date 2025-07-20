'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "b57f7436cb54f105b9a67141cd95c3e5",
"version.json": "cf18ad45cab4d4825502c2a6be0de1f4",
"index.html": "b9d237e9830a46da40fc3305113b1943",
"/": "b9d237e9830a46da40fc3305113b1943",
"images/image8.jpg": "0f3f8c4d1da896bd38ae32e2bbeb5ad1",
"images/image9.jpg": "37a645e3bd4b7debb4eb6d2126c91c7f",
"images/image14.jpg": "275ab1536e79d296baf14d6793d7ca32",
"images/image28.jpg": "1647d7f605eea9ef29f6e812a421c88c",
"images/image29.jpg": "1b50513292702af57af8c88da6004502",
"images/image15.jpg": "0c41d2f1cf7973701327cd880dc0240f",
"images/image17.jpg": "b12cb0e02b446ed2826c3a68a1b7e0a9",
"images/image16.jpg": "916cb1b620a55903fa650dca85e180f5",
"images/image12.jpg": "3e3c1e8cc4341e4983d89e558809e784",
"images/image13.jpg": "cf6e295e4d4c5eae25efe96b392260b0",
"images/image39.jpg": "eab083c07260fdad700007ee7da8302d",
"images/image11.jpg": "86721a5cff2230b5960ffe9fb41dfa00",
"images/image10.jpg": "9dfbfec0e041f8ef6c9a8c50c7d4c6e3",
"images/image38.jpg": "1ad3c54e1ae0a1c353e61d184cac40db",
"images/image21.jpg": "0be9a4320fd5131e54f98529185a517c",
"images/image35.jpg": "6d9548be30ecf003f4d9a0950914d20f",
"images/image34.jpg": "7488a384974247019262358b68a04234",
"images/image20.jpg": "3dbaf87d8e4be1bdb071640e242e7bdb",
"images/image36.jpg": "e31186099f2f046afe76b0f25a0e6a5f",
"images/image22.jpg": "fdabc34958a9659fb5ad07699466fe47",
"images/image23.jpg": "4e2ee2ed768c72f357e7599b12809c4e",
"images/image37.jpg": "a145748306de1bf5d3bc48eab00fda1b",
"images/image33.jpg": "3ccb9f4c08b241bb67b05ee42d43264e",
"images/image27.jpg": "7047635b200f3853038a4007709c5b92",
"images/image26.jpg": "76fb9ca904531907040c48a640ce3b2b",
"images/image32.jpg": "d6899573161d818cae12ce912d0f7c86",
"images/image18.jpg": "34134581f44386de62e47ef4c76ea6b2",
"images/image24.jpg": "3f32914028cc8090c2488fcdf6bba3b9",
"images/image30.jpg": "799076dc680c881576508b25e27f3b37",
"images/image31.jpg": "914aa85d2ad916677c71602a5934cfb6",
"images/image25.jpg": "f067134cd374e34c6073fd2f51ffa89b",
"images/image19.jpg": "7fb33d0144e2e9703eb23ea3f3ebc7fb",
"images/image7.jpg": "05a07a97636e2dda95859f84c2ec8884",
"images/image42.jpg": "b57997fc280bc759d12860ee09406506",
"images/image43.jpg": "253ef81b2eae99f987829609173a9662",
"images/image6.jpg": "168139776d7210b920e659fe55c2f124",
"images/image4.jpg": "58ce4168dfae5425a98169b7d6700a5e",
"images/image41.jpg": "bb78c61abaa15a21842d2eec8663e5f8",
"images/image40.jpg": "bea37f10d73458afbe11b16ba324ebf9",
"images/image5.jpg": "e225f144ca95b278c54ee1f5c5eecf5c",
"images/image1.jpg": "6d8bd92c2bafabf18d1279a682e4120c",
"images/image2.jpg": "d767feb0958bcd9600157b55386d3825",
"images/image3.jpg": "222b5b9e092616354d3ad9c978baa9ba",
"main.dart.js": "5ff90b58e8e28256ff3415233f22dc74",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "24de57006bd0863387e9b52636d96214",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/NOTICES": "f354cb3267ba59cbcdf3cdf92d1564b6",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "69a99f98c8b1fb8111c5fb961769fcd8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/fonts/MaterialIcons-Regular.otf": "07d0b9650148dcfe6c8d99d67dc43149",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
