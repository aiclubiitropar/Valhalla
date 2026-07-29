export const getBaseUrl = () => {
  const url = import.meta.env.VITE_BACKEND_URL || "";
  return url.replace(/\/+$/, "");
};

export const getWsUrl = () => {
  const backendUrl = import.meta.env.VITE_BACKEND_URL;
  if (backendUrl) {
    return backendUrl.replace(/^http/, 'ws').replace(/\/+$/, "");
  }
  const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
  return `${protocol}//${window.location.host}`;
};
