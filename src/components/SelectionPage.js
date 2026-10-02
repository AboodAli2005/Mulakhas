import { Typography } from "@mui/material";
import Container from "@mui/material/Container";
import { Card, CardActionArea, Box, Chip } from "@mui/material";
import CardContent from "@mui/material/CardContent";
import { Grid } from "@mui/material";
import CircularProgress from "@mui/material/CircularProgress";
import Fade from "@mui/material/Fade";
import ArrowBackIosNewIcon from "@mui/icons-material/ArrowBackIosNew";

/**
 * Reusable selection page for Major / Level / Semester flows.
 *
 * @param {string}   title    – page heading
 * @param {Array}    items    – list of selectable items ({ id, name })
 * @param {boolean}  loading  – whether data is still loading
 * @param {Function} onSelect – called with the selected item
 */
export default function SelectionPage({ title, items, loading, onSelect }) {
  if (loading) {
    return (
      <Container
        maxWidth="lg"
        sx={{
          marginTop: 6,
          display: "flex",
          justifyContent: "center",
        }}
      >
        <CircularProgress />
      </Container>
    );
  }

  return (
    <Fade in={true} timeout={500}>
      <Container maxWidth="lg" sx={{ marginTop: 4, marginBottom: 4 }}>
        <Box sx={{ mb: 3 }}>
          <Typography sx={{ fontSize: 26, fontWeight: "800" }}>
            {title}
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
            اختر من الخيارات أدناه للمتابعة
          </Typography>
        </Box>
        <Grid container spacing={2.5}>
          {(items ?? []).map((item, idx) => (
            <Grid size={{ md: 6, xs: 12 }} key={item.id}>
              <Card
                sx={{
                  bgcolor: "background.paper",
                  border: "1px solid",
                  borderColor: "divider",
                  borderRadius: 3,
                  transition: "all 0.25s ease",
                  "&:hover": {
                    transform: "translateY(-4px)",
                    boxShadow: "0 12px 30px rgba(0,0,0,0.1)",
                    borderColor: "primary.main",
                    cursor: "pointer",
                  },
                }}
              >
                <CardActionArea onClick={() => onSelect(item)}>
                  <CardContent
                    sx={{
                      padding: 3,
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "space-between",
                    }}
                  >
                    <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
                      <Chip
                        label={idx + 1}
                        size="small"
                        color="primary"
                        sx={{
                          fontWeight: 700,
                          minWidth: 32,
                          height: 32,
                          fontSize: 14,
                        }}
                      />
                      <Typography sx={{ fontSize: 20, fontWeight: "700" }}>
                        {item.name}
                      </Typography>
                    </Box>
                    <ArrowBackIosNewIcon
                      sx={{
                        fontSize: 16,
                        color: "text.secondary",
                        transform: "rotate(180deg)",
                      }}
                    />
                  </CardContent>
                </CardActionArea>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Container>
    </Fade>
  );
}
