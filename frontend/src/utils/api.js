export const getBaseUrl = () => {
  return import.meta.env.VITE_BACKEND_URL || "";
};

export const getWsUrl = () => {
  const backendUrl = import.meta.env.VITE_BACKEND_URL;
  if (backendUrl) {
    return backendUrl.replace(/^http/, 'ws');
  }
  const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
  return `${protocol}//${window.location.host}`;
};
