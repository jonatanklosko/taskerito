const TOKEN_KEY = localStorageKey('token');

const cache = {
  token: localStorage.getItem(TOKEN_KEY),
};

export function getToken() {
  return cache.token;
}

export function storeToken(token) {
  cache.token = token;
  localStorage.setItem(TOKEN_KEY, token);
}

export function clearToken() {
  cache.token = null;
  localStorage.removeItem(TOKEN_KEY);
}

function localStorageKey(key) {
  const env = process.env.NODE_ENV || 'development';
  return `taskerito-${env}-${key}`;
}
