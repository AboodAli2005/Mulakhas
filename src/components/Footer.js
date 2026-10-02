import { Box, Typography, Container, Divider, IconButton } from "@mui/material";
import TelegramIcon from "@mui/icons-material/Telegram";
import InstagramIcon from "@mui/icons-material/Instagram";

export default function Footer() {
  return (
    <Box
      component="footer"
      sx={{
        bgcolor: "background.paper",
        borderTop: "1px solid",
        borderColor: "divider",
        py: 4,
      }}
    >
      <Container maxWidth="lg">
        <Box
          sx={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            flexWrap: "wrap",
            gap: 2,
            mb: 2,
          }}
        >
          <Box>
            <Typography
              sx={{ fontSize: 15, fontWeight: "700", color: "text.primary" }}
            >
              منصة ملخص | Mulakhas
            </Typography>
            <Typography
              sx={{ fontSize: 13, color: "text.secondary", mt: 0.5 }}
            >
              تم إنشاء هذا الموقع من قبل{" "}
              <Box
                component="span"
                sx={{ fontWeight: 700, color: "primary.main" }}
              >
                GSE
              </Box>
            </Typography>
          </Box>
          <Box sx={{ display: "flex", gap: 1 }}>
            <IconButton
              size="small"
              sx={{
                color: "text.secondary",
                "&:hover": { color: "#0088cc", bgcolor: "action.hover" },
                transition: "color 0.2s",
              }}
              aria-label="Telegram"
            >
              <TelegramIcon />
            </IconButton>
            <IconButton
              size="small"
              sx={{
                color: "text.secondary",
                "&:hover": { color: "#E1306C", bgcolor: "action.hover" },
                transition: "color 0.2s",
              }}
              aria-label="Instagram"
            >
              <InstagramIcon />
            </IconButton>
          </Box>
        </Box>
        <Divider sx={{ mb: 2 }} />
        <Typography
          sx={{
            fontSize: 13,
            fontWeight: "500",
            color: "text.secondary",
            textAlign: "center",
          }}
        >
          © {new Date().getFullYear()} جميع الحقوق محفوظة | GSE
        </Typography>
      </Container>
    </Box>
  );
}
