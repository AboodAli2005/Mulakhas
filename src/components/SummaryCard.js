import { Card } from "@mui/material";
import CardContent from "@mui/material/CardContent";
import Grid from "@mui/material/Grid";
import { Typography, Box, Chip } from "@mui/material";
import { Button } from "@mui/material";
import LibraryBooksOutlinedIcon from "@mui/icons-material/LibraryBooksOutlined";
import VideoLibraryOutlinedIcon from "@mui/icons-material/VideoLibraryOutlined";
import DownloadIcon from "@mui/icons-material/Download";

const BASE_URL = "https://aug-backpack.runasp.net";

export default function SummaryCard({ summary, type }) {
  const isLecture = type === "المحاضرات";

  const handleOpen = () => {
    const url = summary.driveLink ?? `${BASE_URL}${summary.documentPath}`;
    window.open(url, "_blank");
  };

  return (
    <Card
      sx={{
        bgcolor: "background.paper",
        border: "1px solid",
        borderColor: "divider",
        borderRadius: 3,
        transition: "all 0.25s ease",
        height: "100%",
        display: "flex",
        flexDirection: "column",
        "&:hover": {
          transform: "translateY(-4px)",
          boxShadow: "0 12px 30px rgba(0,0,0,0.12)",
          borderColor: "primary.main",
          cursor: "pointer",
        },
      }}
    >
      <CardContent sx={{ flexGrow: 1, p: 3 }}>
        <Grid container spacing={2} alignItems="flex-start">
          <Grid size={3} sx={{ display: "flex", alignItems: "center", justifyContent: "center", pt: 0.5 }}>
            <Box
              sx={{
                bgcolor: isLecture ? "rgba(59, 130, 246, 0.12)" : "rgba(30, 58, 138, 0.1)",
                p: 1.5,
                borderRadius: 2.5,
                display: "inline-flex",
              }}
            >
              {isLecture ? (
                <VideoLibraryOutlinedIcon sx={{ color: "primary.main", fontSize: 30 }} />
              ) : (
                <LibraryBooksOutlinedIcon sx={{ color: "primary.main", fontSize: 30 }} />
              )}
            </Box>
          </Grid>
          <Grid size={9}>
            <Typography
              gutterBottom
              sx={{ fontSize: 16, fontWeight: "700", lineHeight: 1.4, mb: 0.5 }}
            >
              {summary.title}
            </Typography>
            {summary.subjectName && (
              <Chip
                label={summary.subjectName}
                size="small"
                variant="outlined"
                color="primary"
                sx={{ fontSize: 11, fontWeight: 600, height: 22 }}
              />
            )}
          </Grid>
        </Grid>
        <Button
          onClick={handleOpen}
          variant="contained"
          startIcon={<DownloadIcon />}
          sx={{
            width: "100%",
            padding: "10px",
            marginTop: 2.5,
            borderRadius: 2,
            fontWeight: 700,
            bgcolor: "primary.main",
            boxShadow: "0 4px 14px 0 rgba(30, 58, 138, 0.25)",
            "&:hover": {
              boxShadow: "0 6px 20px rgba(30, 58, 138, 0.35)",
              transform: "translateY(-1px)",
            },
            transition: "all 0.2s ease",
          }}
        >
          {isLecture ? "تحميل المحاضرة" : "تحميل الملخص"}
        </Button>
      </CardContent>
    </Card>
  );
}
