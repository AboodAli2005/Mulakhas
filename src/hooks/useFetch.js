import { useState, useEffect } from "react";

/**
 * Generic data-fetching hook.
 * @param {Function} fetcher - An async function that returns the data array.
 * @param {Array} deps - Effect dependency array.
 */
export function useFetch(fetcher, deps = []) {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(null);

    fetcher()
      .then((result) => {
        if (!cancelled) {
          setData(result ?? []);
          setLoading(false);
        }
      })
      .catch((err) => {
        if (!cancelled) {
          console.error(err);
          setError(err);
          setData([]);
          setLoading(false);
        }
      });

    return () => {
      cancelled = true;
    };
  }, deps); // eslint-disable-line react-hooks/exhaustive-deps

  return { data, loading, error };
}
