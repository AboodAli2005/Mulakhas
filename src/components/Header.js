import React, { useContext, useState } from "react";
import {
  AppBar,
  Toolbar,
  Typography,
  Button,
  IconButton,
  Drawer,
  List,
  ListItem,
  ListItemText,
  Box,
  Container,
  FormControlLabel,
  Chip,
  Fade
} from "@mui/material";
import MenuIcon from "@mui/icons-material/Menu";
import { ColorModeContext } from "../contexts/ThemeContext";
import { SelectionContext } from "../contexts/SelectionContext";
import MaterialUISwitch from "../components/MaterialUISwitch";
import { useNavigate, useLocation } from "react-router-dom";
import SchoolIcon from "@mui/icons-material/School";

export default function Header() {
  const { mode, toggleColorMode } = useContext(ColorModeContext);
  const { specialty, level, semester, isLoaded } = useContext(SelectionContext);
  const [mobileOpen, setMobileOpen] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();

  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const handleNavClick = (path) => {
    navigate(path);
    setMobileOpen(false);
  };

  const scrollToSection = (id) => {
    const section = document.getElementById(id);
    if (section) {
      section.scrollIntoView({ behavior: "smooth", block: "start" });
    }
    setMobileOpen(false);
  };

  const hasSelection = specialty || level || semester;

  let dynamicBtnLabel = "اختر التخصص";
  let dynamicBtnPath = "/majors";

  if (specialty && level && semester) {
    dynamicBtnLabel = "عرض المواد";
    dynamicBtnPath = "/summaries";
  } else if (specialty && level) {
    dynamicBtnLabel = "اختر الفصل";
    dynamicBtnPath = "/semester";
  } else if (specialty) {
    dynamicBtnLabel = "اختر السنة";
    dynamicBtnPath = "/level";
  }

  const drawer = (
    <Box sx={{ textAlign: "center", width: 250 }}>
      <Box sx={{ display: "flex", flexDirection: "column", alignItems: "center", my: 3, gap: 1 }}>
        <Box
          component="img"
          src="/logo.jpg"
          alt="لوجو الموقع"
          onClick={() => handleNavClick("/")}
          sx={{
            height: 64,
            width: 64,
            borderRadius: "50%",
            objectFit: "cover",
            cursor: "pointer",
            border: "2px solid",
            borderColor: "primary.main",
            boxShadow: "0 2px 8px rgba(0,0,0,0.15)"
          }}
        />
        <Typography variant="h6" sx={{ fontWeight: "bold", cursor: "pointer" }} onClick={() => handleNavClick("/")}>
          ملخص | Mulakhas
        </Typography>
      </Box>
      <List>
        <ListItem button onClick={() => handleNavClick("/")}>
          <ListItemText primary="الرئيسية" sx={{ textAlign: "center" }} />
        </ListItem>
        <ListItem button onClick={() => scrollToSection("about")}>
          <ListItemText primary="عن الموقع" sx={{ textAlign: "center" }} />
        </ListItem>
        <ListItem button onClick={() => handleNavClick(dynamicBtnPath)} sx={{ mt: 2, px: 2 }}>
          <Button variant="contained" fullWidth color="primary" sx={{ borderRadius: 2, fontWeight: "bold" }}>
            {dynamicBtnLabel}
          </Button>
        </ListItem>
      </List>
    </Box>
  );

  return (
    <>
      <AppBar position="sticky" color="inherit" elevation={hasSelection ? 1 : 0} sx={{ 
        zIndex: 100, 
        borderBottom: hasSelection ? "none" : "1px solid",
        borderColor: "divider",
        transition: "all 0.3s ease"
      }}>
        <Container maxWidth="lg">
          {/* Main Header Row - Increased Height */}
          <Toolbar disableGutters sx={{ 
            justifyContent: "space-between", 
            py: { xs: 1.5, md: 2.5 }, // Taller header
            transition: "all 0.3s ease"
          }}>
            <Box sx={{ display: "flex", alignItems: "center", gap: 1.5 }}>
              <Box
                component="img"
                src="/logo.jpg"
                alt="لوجو الموقع"
                onClick={() => navigate("/")}
                sx={{
                  height: { xs: 40, md: 48 },
                  width: { xs: 40, md: 48 },
                  borderRadius: "50%",
                  objectFit: "cover",
                  cursor: "pointer",
                  border: "2px solid",
                  borderColor: "primary.main",
                  boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
                  transition: "transform 0.2s ease-in-out",
                  "&:hover": {
                    transform: "scale(1.05)"
                  }
                }}
              />
              <Typography
                variant="h5"
                component="div"
                sx={{ fontWeight: "800", cursor: "pointer", display: { xs: "none", sm: "block" } }}
                onClick={() => navigate("/")}
              >
                ملخص | Mulakhas
              </Typography>
            </Box>

            {/* Desktop Navigation */}
            <Box sx={{ display: { xs: "none", md: "flex" }, gap: 1.5, alignItems: "center" }}>
              <Button
                onClick={() => handleNavClick("/")}
                sx={{
                  color: location.pathname === "/" ? "primary.main" : "text.primary",
                  fontWeight: location.pathname === "/" ? 700 : 500,
                  borderRadius: 2,
                  px: 2,
                  py: 1,
                  "&:hover": { bgcolor: "action.hover" },
                }}
              >
                الرئيسية
              </Button>
              <Button
                onClick={() => scrollToSection("about")}
                sx={{ 
                  color: "text.primary", 
                  fontWeight: 500, 
                  px: 2, 
                  py: 1,
                  borderRadius: 2,
                  "&:hover": { bgcolor: "action.hover" } 
                }}
              >
                عن الموقع
              </Button>
              <Button
                variant="contained"
                color="primary"
                onClick={() => handleNavClick(dynamicBtnPath)}
                sx={{ 
                  fontWeight: 700, 
                  px: 3, 
                  py: 1,
                  ml: 1,
                  borderRadius: 2,
                  boxShadow: "0 4px 14px 0 rgba(37, 99, 235, 0.39)",
                  "&:hover": { transform: "translateY(-1px)", boxShadow: "0 6px 20px rgba(37, 99, 235, 0.4)" },
                  transition: "all 0.2s ease"
                }}
              >
                {dynamicBtnLabel}
              </Button>
            </Box>

            <Box sx={{ display: "flex", alignItems: "center", gap: 1 }}>
              <FormControlLabel
                control={<MaterialUISwitch checked={mode === "dark"} onChange={toggleColorMode} />}
                label=""
                sx={{ m: 0 }}
              />
              <IconButton
                color="inherit"
                aria-label="open drawer"
                edge="start"
                onClick={handleDrawerToggle}
                sx={{ display: { md: "none" } }}
              >
                <MenuIcon />
              </IconButton>
            </Box>
          </Toolbar>

          {/* Selection Bar Section - Only shown if data exists */}
          {isLoaded && hasSelection && (
            <Fade in={Boolean(hasSelection)}>
              <Box sx={{ 
                pb: 2, 
                display: "flex", 
                alignItems: "center", 
                gap: 1, 
                flexWrap: "wrap",
                borderTop: "1px solid",
                borderColor: "divider",
                pt: 2
              }}>
                <SchoolIcon sx={{ fontSize: 18, color: "text.secondary", mr: 0.5 }} />
                {specialty && (
                  <Chip 
                    label={specialty.name} 
                    size="small" 
                    variant="outlined" 
                    color="primary" 
                    onClick={() => navigate("/majors")}
                    sx={{ fontWeight: 600 }}
                  />
                )}
                {level && (
                  <Chip 
                    label={level.name} 
                    size="small" 
                    variant="outlined" 
                    onClick={() => navigate("/level")}
                    sx={{ fontWeight: 600 }}
                  />
                )}
                {semester && (
                  <Chip 
                    label={semester.name} 
                    size="small" 
                    variant="outlined" 
                    onClick={() => navigate("/semester")}
                    sx={{ fontWeight: 600 }}
                  />
                )}
              </Box>
            </Fade>
          )}
        </Container>
      </AppBar>

      {/* Mobile Drawer */}
      <Drawer
        anchor="right"
        open={mobileOpen}
        onClose={handleDrawerToggle}
        ModalProps={{ keepMounted: true }}
        sx={{
          display: { xs: "block", md: "none" },
          "& .MuiDrawer-paper": { boxSizing: "border-box", width: 250 },
        }}
      >
        {drawer}
      </Drawer>
    </>
  );
}
