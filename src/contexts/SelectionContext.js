import { createContext, useEffect, useState } from "react";

export const SelectionContext = createContext(null);

export const SelectionProvider = ({ children }) => {
  const [specialty, setSpecialty] = useState(null);
  const [level, setLevel] = useState(null);
  const [semester, setSemester] = useState(null);
  const [isLoaded, setIsLoaded] = useState(false);

  // Load from sessionStorage on mount (Client-side only)
  useEffect(() => {
    const saved = sessionStorage.getItem("userSelection");
    if (saved) {
      try {
        const { major, year, semester: sem } = JSON.parse(saved);
        setSpecialty(major || null);
        setLevel(year || null);
        setSemester(sem || null);
      } catch (e) {
        console.error("Error parsing userSelection from sessionStorage", e);
      }
    }
    setIsLoaded(true);
  }, []);

  // Save to sessionStorage whenever selections change
  useEffect(() => {
    if (isLoaded) {
      if (!specialty && !level && !semester) {
        sessionStorage.removeItem("userSelection");
      } else {
        const selection = {
          major: specialty,
          year: level,
          semester: semester
        };
        sessionStorage.setItem("userSelection", JSON.stringify(selection));
      }
    }
  }, [specialty, level, semester, isLoaded]);

  const resetSelection = () => {
    setSpecialty(null);
    setLevel(null);
    setSemester(null);
    sessionStorage.removeItem("userSelection");
  };

  return (
    <SelectionContext.Provider
      value={{
        specialty,
        setSpecialty,
        level,
        setLevel,
        semester,
        setSemester,
        resetSelection,
        isLoaded
      }}
    >
      {children}
    </SelectionContext.Provider>
  );
};
