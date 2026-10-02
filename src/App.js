import React from "react";
import { Routes, Route } from "react-router-dom";
import { Box } from "@mui/material";
import Header from "./components/Header";
import Footer from "./components/Footer";
import Home from "./pages/Home";

import Major from "./pages/Major";
import Levels from "./pages/Levels";
import Semester from "./pages/Semester";
import Summaries from "./pages/Summaries";
import About from "./pages/About";
import { SelectionProvider } from "./contexts/SelectionContext";
import "./App.css";

function App() {
  return (
    <SelectionProvider>
      <Box sx={{ display: "flex", flexDirection: "column", minHeight: "100vh" }}>
        <Header />
        <Box component="main" sx={{ flexGrow: 1 }}>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/majors" element={<Major />} />
            <Route path="/level" element={<Levels />} />
            <Route path="/semester" element={<Semester />} />
            <Route path="/summaries" element={<Summaries />} />
          </Routes>
        </Box>
        <About />
        <Footer />
      </Box>
    </SelectionProvider>
  );
}

export default App;
