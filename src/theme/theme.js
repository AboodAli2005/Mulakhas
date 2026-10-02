import { createTheme } from "@mui/material/styles";
import "../App.css";

export const getTheme = (mode) =>
  createTheme({
    palette: {
      mode,
      ...(mode === "light"
        ? {
            primary: {
              main: "#1e3a8a", // Darker Navy Blue
              contrastText: "#ffffff",
            },
            secondary: {
              main: "#475569",
            },
            background: {
              default: "#f8fafc",
              paper: "#ffffff",
            },
            text: {
              primary: "#0f172a",
              secondary: "#64748b",
            },
            button: {
              primary: "#1e3a8a",
            },
          }
        : {
            primary: {
              main: "#3b82f6", // Muted Blue for Dark Mode
              contrastText: "#ffffff",
            },
            secondary: {
              main: "#94a3b8",
            },
            background: {
              default: "#0f172a",
              paper: "#1e293b",
            },
            text: {
              primary: "#f8fafc",
              secondary: "#94a3b8",
            },
            button: {
              primary: "#3b82f6",
            },
          }),
    },

    typography: {
      fontFamily: "Cairo, Roboto, Arial, sans-serif",
      button: {
        textTransform: "none",
        fontWeight: 600,
      },
    },
  });
