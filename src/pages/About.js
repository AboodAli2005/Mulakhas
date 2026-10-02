import { Typography, Box, Paper, Grid, Divider } from "@mui/material";
import Container from "@mui/material/Container";
import InfoOutlinedIcon from "@mui/icons-material/InfoOutlined";
import SchoolOutlinedIcon from "@mui/icons-material/SchoolOutlined";
import AutoStoriesOutlinedIcon from "@mui/icons-material/AutoStoriesOutlined";

export default function About() {
  return (
    <Container id="about" maxWidth="lg" sx={{ marginTop: 8, marginBottom: 8 }}>
      <Paper
        elevation={0}
        sx={{
          padding: { xs: 4, md: 6 },
          borderRadius: 4,
          background: "linear-gradient(145deg, rgba(255,255,255,0.05) 0%, rgba(255,255,255,0) 100%)",
          border: "1px solid",
          borderColor: "divider",
          position: "relative",
          overflow: "hidden",
        }}
      >
        <Box sx={{ display: "flex", alignItems: "center", gap: 2, marginBottom: 4 }}>
          <InfoOutlinedIcon sx={{ fontSize: 40, color: "primary.main" }} />
          <Typography
            variant="h4"
            sx={{
              fontWeight: "800",
              background: "linear-gradient(45deg, #2196F3 30%, #21CBF3 90%)",
              WebkitBackgroundClip: "text",
              WebkitTextFillColor: "transparent",
            }}
          >
            عن المنصة التعليمية
          </Typography>
        </Box>

        <Grid container spacing={4}>
          <Grid size={{ xs: 12, md: 7 }}>
            <Typography variant="body1" sx={{ fontSize: 18, lineHeight: 1.8, color: "text.secondary", textAlign: "justify" }}>
              مرحباً بكم في منصتنا التعليمية المتخصصة. نهدف من خلال هذا الموقع إلى توفير كافة الملخصات والمحاضرات الجامعية التي يحتاجها الطلاب في مسيرتهم الأكاديمية. فريقنا يعمل باستمرار على تحديث المحتوى لضمان تقديم أفضل تجربة تعليمية ممكنة، وتسهيل الوصول للمعلومات الأكاديمية بكل يسر وسهولة.
            </Typography>
            <Box sx={{ mt: 4 }}>
              <Typography variant="h6" sx={{ fontWeight: 700, mb: 2 }}>
                رؤيتنا
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ fontSize: 16 }}>
                أن نكون المرجع الأول والطريق الأسهل لطلابنا للوصول إلى التميز الدراسي من خلال محتوى أكاديمي منظم وعالي الجودة.
              </Typography>
            </Box>
          </Grid>

          <Grid size={{ xs: 12, md: 5 }}>
            <Box
              sx={{
                display: "flex",
                flexDirection: "column",
                gap: 3,
                bgcolor: "background.paper",
                p: 3,
                borderRadius: 3,
                border: "1px solid",
                borderColor: "divider",
                boxShadow: "0 4px 20px rgba(0,0,0,0.05)",
                transition: "transform 0.3s ease, box-shadow 0.3s ease",
                "&:hover": {
                  transform: "translateY(-5px)",
                  boxShadow: "0 8px 30px rgba(0,0,0,0.1)",
                }
              }}
            >
              <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
                <SchoolOutlinedIcon color="primary" />
                <Typography sx={{ fontWeight: 600 }}>دعم أكاديمي متكامل</Typography>
              </Box>
              <Divider />
              <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
                <AutoStoriesOutlinedIcon color="primary" />
                <Typography sx={{ fontWeight: 600 }}>ملخصات شاملة لجميع المواد</Typography>
              </Box>
              <Divider />
              <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
                <InfoOutlinedIcon color="primary" />
                <Typography sx={{ fontWeight: 600 }}>تحديثات مستمرة للمحتوى</Typography>
              </Box>
            </Box>
          </Grid>
        </Grid>
      </Paper>
    </Container>
  );
}
