// Components Imports
import SummaryCard from "../components/SummaryCard";
import SelectionSummary from "../components/SelectionSummary";

// MUI Imports
import { Typography, Button, Box, Container } from "@mui/material";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Select from "@mui/material/Select";
import TextField from "@mui/material/TextField";
import { Grid } from "@mui/material";
import ToggleButton from "@mui/material/ToggleButton";
import ToggleButtonGroup from "@mui/material/ToggleButtonGroup";
import CircularProgress from "@mui/material/CircularProgress";
import SearchOffIcon from "@mui/icons-material/SearchOff";
import Fade from "@mui/material/Fade";

// Hooks Imports
import { useState, useEffect, useContext } from "react";
import { useFetch } from "../hooks/useFetch";
import { SelectionContext } from "../contexts/SelectionContext";

// API Imports
import { getSubjects, getSummaries, getLectures } from "../api";

export default function Summaries() {
  const [inputValue, setInputValue] = useState("");
  const [debouncedInput, setDebouncedInput] = useState("");
  const [selectValue, setSelectValue] = useState("");

  const [summaries, setSummaries] = useState([]);
  const [lectures, setLectures] = useState([]);

  const [loadingItems, setLoadingItems] = useState(false);

  const [allLecturesVisible, setLecturesVisible] = useState(false);
  const [allSummariesVisible, setSummariesVisible] = useState(false);

  const { specialty, level, semester, isLoaded } = useContext(SelectionContext);

  const storedSpecialty = specialty || {};
  const storedLevel = level || {};
  const storedSemester = semester || {};

  const [alignment, setAlignment] = useState("الملخصات");



  // Fetch Subjects
  const { data: subjects, loading: loadingSubjects } = useFetch(
    () =>
      getSubjects({
        specialtyId: storedSpecialty?.id,
        levelId: storedLevel?.id,
        semesterId: storedSemester?.id,
      }),
    [storedSpecialty?.id, storedLevel?.id, storedSemester?.id]
  );

  function handleChange(e) {
    if (e.target.value !== null) {
      setAlignment(e.target.value);
    }
  }

  // Debounce search input
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedInput(inputValue);
    }, 500);
    return () => clearTimeout(timer);
  }, [inputValue]);

  // Fetch Summaries
  useEffect(() => {
    let cancelled = false;
    if (alignment !== "الملخصات") return;

    const fetchItems = async () => {
      setLoadingItems(true);
      try {
        const data = await getSummaries({
          specialtyId: storedSpecialty?.id,
          levelId: storedLevel?.id,
          semesterId: storedSemester?.id,
          subjectId: selectValue,
          keyword: debouncedInput,
          take: allSummariesVisible ? null : 9,
        });
        if (!cancelled) {
          setSummaries(data || []);
        }
      } catch (error) {
        console.error(error);
        if (!cancelled) setSummaries([]);
      } finally {
        if (!cancelled) setLoadingItems(false);
      }
    };
    fetchItems();
    return () => {
      cancelled = true;
    };
  }, [selectValue, debouncedInput, allSummariesVisible, alignment, storedSpecialty?.id, storedLevel?.id, storedSemester?.id]);

  // Fetch Lectures
  useEffect(() => {
    let cancelled = false;
    if (alignment !== "المحاضرات") return;

    const fetchItems = async () => {
      setLoadingItems(true);
      try {
        const data = await getLectures({
          specialtyId: storedSpecialty?.id,
          levelId: storedLevel?.id,
          semesterId: storedSemester?.id,
          subjectId: selectValue,
          keyword: debouncedInput,
          take: allLecturesVisible ? null : 9,
        });
        if (!cancelled) {
          setLectures(data || []);
        }
      } catch (error) {
        console.error(error);
        if (!cancelled) setLectures([]);
      } finally {
        if (!cancelled) setLoadingItems(false);
      }
    };
    fetchItems();
    return () => {
      cancelled = true;
    };
  }, [selectValue, debouncedInput, allLecturesVisible, alignment, storedSpecialty?.id, storedLevel?.id, storedSemester?.id]);

  function handleSearch(e) {
    setInputValue(e.target.value);
  }

  const renderEmptyState = (message) => (
    <Box
      sx={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        padding: 5,
        color: "text.secondary",
      }}
    >
      <SearchOffIcon sx={{ fontSize: 60, marginBottom: 2, opacity: 0.5 }} />
      <Typography variant="h6" sx={{ fontWeight: 600 }}>
        {message}
      </Typography>
    </Box>
  );

  if (!isLoaded) {
    return (
      <Box sx={{ display: "flex", justifyContent: "center", mt: 10 }}>
        <CircularProgress />
      </Box>
    );
  }

  return (
    <Fade in={true} timeout={500}>
      <Container maxWidth="lg" sx={{ marginTop: 3 }}>
      <SelectionSummary />
      <Box
        sx={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          marginBottom: 3,
        }}
      >
        <Typography sx={{ fontSize: 24, fontWeight: "700" }}>
          {alignment === "الملخصات"
            ? "الملخصات المتاحة"
            : "المحاضرات المتاحة"}
        </Typography>
      </Box>
      <Typography
        gutterBottom
        sx={{ fontSize: 15, fontWeight: "400", marginBottom: 2 }}
      >
        {alignment === "الملخصات"
          ? "ابحث عن الملخص المطلوب وحمله مباشرة."
          : "ابحث عن المحاضرة المطلوبة وحملها مباشرة."}
      </Typography>
      <Grid container spacing={2} sx={{ marginBottom: 3 }}>
        <Grid item size={{ md: 8, xs: 12 }}>
          <FormControl fullWidth>
            <TextField
              sx={{
                "& .MuiInputLabel-root": { color: "text.secondary" },
                "& .MuiInputLabel-root.Mui-focused": { color: "primary.main" },
              }}
              id="outlined-basic"
              label="ابحث..."
              variant="outlined"
              value={inputValue}
              onChange={handleSearch}
            />
          </FormControl>
        </Grid>
        <Grid size={{ md: 4, sm: 6, xs: 12 }} >

          <FormControl fullWidth disabled={loadingSubjects}>
            <InputLabel
              id="demo-simple-select-label"
              sx={{
                color: "text.secondary",
                "&.Mui-focused": { color: "primary.main" },
              }}
            >
              المادة
            </InputLabel>
            <Select
              labelId="demo-simple-select-label"
              id="demo-simple-select"
              value={selectValue}
              label="المادة"
              onChange={(e) => setSelectValue(e.target.value)}
            >
              <MenuItem value="">
                <em>الكل</em>
              </MenuItem>
              {subjects?.map((s) => (
                <MenuItem key={s.id} value={s.id}>
                  {s.title}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
        </Grid>
      </Grid>

      <ToggleButtonGroup
        sx={{ width: "100%", direction: "ltr", marginBottom: 3 }}
        color="primary"
        value={alignment}
        exclusive
        onChange={handleChange}
        aria-label="Platform"
      >
        <ToggleButton value="المحاضرات" sx={{ width: "50%", fontWeight: 600 }}>
          المحاضرات
        </ToggleButton>
        <ToggleButton value="الملخصات" sx={{ width: "50%", fontWeight: 600 }}>
          الملخصات
        </ToggleButton>
      </ToggleButtonGroup>

      {loadingItems ? (
        <Box sx={{ display: "flex", justifyContent: "center", padding: 5 }}>
          <CircularProgress />
        </Box>
      ) : alignment === "الملخصات" ? (
        summaries.length === 0 ? (
          renderEmptyState("لا يوجد ملخصات لهذا الاختيار")
        ) : (
          <>
            <Grid container spacing={2}>
              {summaries.map((s) => (
                <Grid size={{ md: 4, sm: 6, xs: 12 }} key={s.id}>
                  <SummaryCard summary={s} type={alignment} />
                </Grid>
              ))}
            </Grid>
            <Box sx={{ display: "flex", justifyContent: "center", marginTop: 3 }}>
              <Button
                variant="contained"
                onClick={() => setSummariesVisible(!allSummariesVisible)}
                sx={{
                  visibility: (summaries.length >= 9 || allSummariesVisible) ? "visible" : "hidden",
                  bgcolor: "button.primary",
                  borderRadius: 2,
                  fontWeight: 600,
                  fontSize: 14,
                  px: 2.5,
                  py: 1,
                  boxShadow: 3,
                }}
              >
                {allSummariesVisible ? "عرض أقل" : "عرض الكل"}
              </Button>
            </Box>
          </>
        )
      ) : lectures.length === 0 ? (
        renderEmptyState("لا يوجد محاضرات لهذا الاختيار")
      ) : (
        <>
          <Grid container spacing={2}>
            {lectures.map((s) => (
              <Grid size={{ md: 4, sm: 6, xs: 12 }} key={s.id}>
                <SummaryCard summary={s} type={alignment} />
              </Grid>
            ))}
          </Grid>
          <Box sx={{ display: "flex", justifyContent: "center", marginTop: 3 }}>
            <Button
              variant="contained"
              onClick={() => setLecturesVisible(!allLecturesVisible)}
              sx={{
                visibility: (lectures.length >= 9 || allLecturesVisible) ? "visible" : "hidden",
                bgcolor: "button.primary",
                borderRadius: 2,
                textTransform: "none",
                fontWeight: 600,
                fontSize: 14,
                px: 2.5,
                py: 1,
                boxShadow: 3,
                mb: 3,
              }}
            >
              {allLecturesVisible ? "عرض أقل" : "عرض الكل"}
            </Button>
          </Box>
        </>
      )}
      </Container>
    </Fade>
  );
}
