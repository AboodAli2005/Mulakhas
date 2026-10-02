import React from "react";
import { Container, Typography, Button, Box, Grid, Card, Paper, Fade } from "@mui/material";
import SchoolOutlinedIcon from "@mui/icons-material/SchoolOutlined";
import FindInPageOutlinedIcon from "@mui/icons-material/FindInPageOutlined";
import UpdateOutlinedIcon from "@mui/icons-material/UpdateOutlined";
import DevicesOutlinedIcon from "@mui/icons-material/DevicesOutlined";
import CheckCircleOutlineIcon from "@mui/icons-material/CheckCircleOutline";
import ArrowForwardIcon from "@mui/icons-material/ArrowForward";
import { useNavigate } from "react-router-dom";



export default function Home() {
  const navigate = useNavigate();

  const handleStart = () => {
    navigate("/majors");
  };

  const features = [
    {
      title: "منظم حسب التخصص، السنة، والفصل",
      desc: "تصفح الملخصات والمحاضرات بسهولة تامة بناءً على تخصصك الأكاديمي وسنتك الدراسية.",
      icon: <SchoolOutlinedIcon color="primary" sx={{ fontSize: 40 }} />,
    },
    {
      title: "بحث وتصفية سريع",
      desc: "ابحث عن أي مادة أو محاضرة بلمح البصر باستخدام أدوات البحث والتصفية المتقدمة.",
      icon: <FindInPageOutlinedIcon color="primary" sx={{ fontSize: 40 }} />,
    },
    {
      title: "محتوى محدث باستمرار",
      desc: "نضمن لك الحصول على أحدث المحاضرات والملخصات المعتمدة من قبل طاقم الدعم الأكاديمي.",
      icon: <UpdateOutlinedIcon color="primary" sx={{ fontSize: 40 }} />,
    },
    {
      title: "واجهة سلسة وسريعة",
      desc: "تصميم عصري متجاوب يعمل بشكل ممتاز على جميع الأجهزة لتجربة دراسة أفضل.",
      icon: <DevicesOutlinedIcon color="primary" sx={{ fontSize: 40 }} />,
    },
  ];

  const steps = [
    { num: "1", title: "اختر تخصصك", desc: "حدد تخصصك الجامعي من القائمة" },
    { num: "2", title: "حدد السنة الدراسية", desc: "اختر السنة التي تدرس بها حالياً" },
    { num: "3", title: "اختر الفصل", desc: "حدد الفصل الدراسي المطلوب" },
    { num: "4", title: "تصفح وحمل", desc: "استعرض كافة المواد وحمل ملخصاتك" },
  ];

  const reasons = [
    "يوفر وقتك في البحث عن المصادر",
    "جميع المقررات في مكان واحد",
    "واجهة مصممة خصيصاً لراحة الطالب",
    "تحديثات مستمرة للمقررات",
  ];

  return (
    <Fade in={true} timeout={800}>
      <Box>
        {/* HERO SECTION */}
        <Box
          sx={{
            py: { xs: 8, md: 14 },
            background: (theme) =>
              theme.palette.mode === "light"
                ? "linear-gradient(180deg, rgba(30, 58, 138, 0.08) 0%, rgba(255, 255, 255, 0) 100%)"
                : "linear-gradient(180deg, rgba(59, 130, 246, 0.08) 0%, rgba(0, 0, 0, 0) 100%)",
            borderBottom: "1px solid",
            borderColor: "divider",
          }}
        >
          <Container maxWidth="md">
            <Box sx={{ display: "flex", justifyContent: "center", mb: 3 }}>
              <Box
                component="img"
                src="/logo.jpg"
                alt="لوجو الموقع"
                sx={{
                  height: { xs: 80, md: 100 },
                  width: { xs: 80, md: 100 },
                  borderRadius: "50%",
                  objectFit: "cover",
                  border: "3px solid",
                  borderColor: "primary.main",
                  boxShadow: "0 4px 20px rgba(0,0,0,0.15)",
                  transition: "transform 0.3s ease",
                  "&:hover": {
                    transform: "scale(1.08)"
                  }
                }}
              />
            </Box>
            <Typography variant="h2" sx={{ fontWeight: 800, fontSize: { xs: "2.5rem", md: "4rem" }, mb: 3, lineHeight: 1.2 }}>
              جميع مذكراتك الجامعية في <Box component="span" sx={{ color: "primary.main" }}>مكان واحد</Box>
            </Typography>
            <Typography variant="h6" color="text.secondary" sx={{ mb: 5, fontWeight: 400, lineHeight: 1.6, px: { xs: 2, md: 8 } }}>
              قم بالوصول إلى الملخصات والمحاضرات والمصادر التعليمية المنظمة بناءً على تخصصك، سنتك الدراسية، والفصل الذي تدرس به بكل سهولة.
            </Typography>
            <Box sx={{ display: "flex", gap: 2, justifyContent: "center", flexWrap: "wrap" }}>
              <Button
                variant="contained"
                size="large"
                onClick={handleStart}
                endIcon={<ArrowForwardIcon />}
                sx={{ borderRadius: "12px", px: 4, py: 1.5, fontSize: "1.1rem", fontWeight: 700, boxShadow: "0 8px 25px rgba(33, 150, 243, 0.3)" }}
              >
                تصفح المواد الآن
              </Button>
              <Button
                variant="outlined"
                size="large"
                onClick={() => document.getElementById("how-it-works").scrollIntoView({ behavior: "smooth" })}
                sx={{ borderRadius: "12px", px: 4, py: 1.5, fontSize: "1.1rem", fontWeight: 600 }}
              >
                كيف يعمل الموقع؟
              </Button>
            </Box>
          </Container>
        </Box>

        {/* FEATURES SECTION */}
        <Container maxWidth="lg" sx={{ py: { xs: 8, md: 12 } }}>
          <Typography variant="h4" textAlign="center" sx={{ fontWeight: 800, mb: 6 }}>
            لماذا منصتنا هي الأفضل؟
          </Typography>
          <Grid container spacing={4}>
            {features.map((feature, idx) => (
              <Grid size={{ xs: 12, sm: 6, md: 3 }} key={idx}>
                <Paper
                  elevation={0}
                  sx={{
                    p: 4,
                    height: "100%",
                    borderRadius: 4,
                    border: "1px solid",
                    borderColor: "divider",
                    transition: "transform 0.3s ease, box-shadow 0.3s ease",
                    "&:hover": { transform: "translateY(-8px)", boxShadow: "0 12px 30px rgba(0,0,0,0.08)" },
                    textAlign: "center",
                    bgcolor: "background.paper",
                  }}
                >
                  <Box sx={{ mb: 2, display: "inline-flex", p: 2, borderRadius: "50%", bgcolor: "rgba(33, 150, 243, 0.1)" }}>
                    {feature.icon}
                  </Box>
                  <Typography variant="h6" sx={{ fontWeight: 700, mb: 1.5 }}>
                    {feature.title}
                  </Typography>
                  <Typography variant="body2" color="text.secondary" sx={{ lineHeight: 1.7 }}>
                    {feature.desc}
                  </Typography>
                </Paper>
              </Grid>
            ))}
          </Grid>
        </Container>

        {/* HOW IT WORKS SECTION */}
        <Box id="how-it-works" sx={{ py: { xs: 8, md: 12 }, bgcolor: "action.hover", borderTop: "1px solid", borderBottom: "1px solid", borderColor: "divider" }}>
          <Container maxWidth="lg">
            <Typography variant="h4" textAlign="center" sx={{ fontWeight: 800, mb: 6 }}>
              كيف تبدأ؟ بخطوات بسيطة
            </Typography>
            <Grid container spacing={4} justifyContent="center">
              {steps.map((step, idx) => (
                <Grid size={{ xs: 12, sm: 6, md: 3 }} key={idx}>
                  <Box sx={{ textAlign: "center", position: "relative" }}>
                    <Box
                      sx={{
                        width: 64,
                        height: 64,
                        borderRadius: "50%",
                        bgcolor: "primary.main",
                        color: "white",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        fontSize: "1.5rem",
                        fontWeight: 800,
                        mx: "auto",
                        mb: 3,
                        boxShadow: "0 4px 15px rgba(33, 150, 243, 0.4)",
                      }}
                    >
                      {step.num}
                    </Box>
                    <Typography variant="h6" sx={{ fontWeight: 700, mb: 1 }}>
                      {step.title}
                    </Typography>
                    <Typography variant="body2" color="text.secondary">
                      {step.desc}
                    </Typography>
                  </Box>
                </Grid>
              ))}
            </Grid>
          </Container>
        </Box>

        {/* WHY THIS PLATFORM */}
        <Container maxWidth="md" sx={{ py: { xs: 8, md: 12 } }}>
          <Card
            elevation={0}
            sx={{
              borderRadius: 4,
              border: "1px solid",
              borderColor: "divider",
              overflow: "hidden",
              bgcolor: "background.paper"
            }}
          >
            <Grid container>
              <Grid
                item
                xs={12}
                md={6}
                sx={{
                  bgcolor: "background.paper",
                  p: { xs: 4, md: 6 },
                  display: "flex",
                  flexDirection: "column",
                  justifyContent: "center"
                }}
              >
                <Typography variant="h4" sx={{ fontWeight: 800, mb: 2 }}>
                  صُممت لتلبي احتياجاتك
                </Typography>
                <Typography variant="body1" sx={{ opacity: 0.9, lineHeight: 1.8 }}>
                  تم بناء هذه المنصة لتوفير وقت وجهد الطلاب عبر تنظيم هائل وسرعة فائقة في استرجاع المقررات الدراسية.
                </Typography>
              </Grid>
              <Grid item xs={12} md={6} sx={{ p: { xs: 4, md: 6 }, bgcolor: "background.paper" }}>
                <Box sx={{ display: "flex", flexDirection: "column", gap: 3 }}>
                  {reasons.map((reason, idx) => (
                    <Box key={idx} sx={{ display: "flex", alignItems: "center", gap: 2 }}>
                      <CheckCircleOutlineIcon color="primary" />
                      <Typography variant="body1" sx={{ fontWeight: 600 }}>{reason}</Typography>
                    </Box>
                  ))}
                </Box>
              </Grid>
            </Grid>
          </Card>
        </Container>

        {/* CTA SECTION */}
        <Box sx={{
          py: { xs: 10, md: 14 },
          textAlign: "center",
          background: (theme) =>
            theme.palette.mode === "light"
              ? "linear-gradient(0deg, rgba(30, 58, 138, 0.08) 0%, rgba(255, 255, 255, 0) 100%)"
              : "linear-gradient(0deg, rgba(59, 130, 246, 0.08) 0%, rgba(0, 0, 0, 0) 100%)",
        }}>
          <Container maxWidth="md">
            <Typography variant="h3" sx={{ fontWeight: 800, mb: 3 }}>
              ابدأ مسيرتك التعليمية الآن
            </Typography>
            <Typography variant="h6" color="text.secondary" sx={{ mb: 5 }}>
              انضم لزملائك واستفد من آلاف الملخصات والمحاضرات المنظمة بعناية.
            </Typography>
            <Button
              variant="contained"
              size="large"
              onClick={handleStart}
              endIcon={<ArrowForwardIcon />}
              sx={{ borderRadius: "12px", px: 5, py: 1.8, fontSize: "1.2rem", fontWeight: 800, boxShadow: "0 10px 30px rgba(33, 150, 243, 0.4)" }}
            >
              اكتشف المواد
            </Button>
          </Container>
        </Box>
      </Box>
    </Fade>
  );
}
