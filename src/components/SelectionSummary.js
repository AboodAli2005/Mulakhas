import React, { useContext } from "react";
import { Box, Chip, Typography, Fade, Button } from "@mui/material";
import EditIcon from "@mui/icons-material/Edit";
import RestartAltIcon from "@mui/icons-material/RestartAlt";
import { SelectionContext } from "../contexts/SelectionContext";
import { useNavigate } from "react-router-dom";

export default function SelectionSummary() {
  const { specialty, level, semester, setLevel, setSemester, resetSelection, isLoaded } = useContext(SelectionContext);
  const navigate = useNavigate();

  // Prevent rendering during hydration to avoid flicker
  if (!isLoaded) return null;

  // Only show if at least one selection exists
  if (!specialty && !level && !semester) return null;

  return (
    <Fade in={true}>
      <Box
        sx={{
          display: "flex",
          alignItems: "center",
          gap: 1.5,
          flexWrap: "wrap",
          p: 2,
          mb: 3,
          bgcolor: "background.paper",
          borderRadius: 3,
          boxShadow: "0 4px 20px rgba(0,0,0,0.05)",
          border: "1px solid",
          borderColor: "divider",
          maxWidth: "lg",
          mx: "auto",
        }}
      >
        <Typography variant="body2" color="text.secondary" sx={{ fontWeight: 700, mr: 1 }}>
          اختياراتك:
        </Typography>

        {specialty && (
          <Chip
            label={`التخصص: ${specialty.name}`}
            onClick={() => {
              setLevel(null);
              setSemester(null);
              navigate("/majors");
            }}
            onDelete={() => {
              setLevel(null);
              setSemester(null);
              navigate("/majors");
            }}
            deleteIcon={<EditIcon sx={{ fontSize: 16 }} />}
            color="primary"
            variant="outlined"
            sx={{ fontWeight: 600, transition: "0.2s", "&:hover": { transform: "translateY(-2px)" } }}
          />
        )}

        {level && (
          <Chip
            label={`السنة: ${level.name}`}
            onClick={() => {
              setSemester(null);
              navigate("/level");
            }}
            onDelete={() => {
              setSemester(null);
              navigate("/level");
            }}
            deleteIcon={<EditIcon sx={{ fontSize: 16 }} />}
            color="secondary"
            variant="outlined"
            sx={{ fontWeight: 600, transition: "0.2s", "&:hover": { transform: "translateY(-2px)" } }}
          />
        )}

        {semester && (
          <Chip
            label={`الفصل: ${semester.name}`}
            onClick={() => navigate("/semester")}
            onDelete={() => navigate("/semester")}
            deleteIcon={<EditIcon sx={{ fontSize: 16 }} />}
            color="success"
            variant="outlined"
            sx={{ fontWeight: 600, transition: "0.2s", "&:hover": { transform: "translateY(-2px)" } }}
          />
        )}

        <Box sx={{ flexGrow: 1 }} />

        <Button
          size="small"
          color="error"
          startIcon={<RestartAltIcon />}
          onClick={() => {
            resetSelection();
            navigate("/");
          }}
          sx={{ fontWeight: 700, textTransform: "none" }}
        >
          إعادة تعيين الاختيارات
        </Button>
      </Box>
    </Fade>
  );
}
