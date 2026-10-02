import { useContext } from "react";
import { useNavigate } from "react-router-dom";
import { SelectionContext } from "../contexts/SelectionContext";
import { getSemesters } from "../api";
import { useFetch } from "../hooks/useFetch";
import SelectionPage from "../components/SelectionPage";

export default function Semester() {
  const { level, setSemester } = useContext(SelectionContext);
  const navigate = useNavigate();

  const { data: semesters, loading } = useFetch(
    () => getSemesters(level?.id),
    [level],
  );

  const handleSelect = (value) => {
    setSemester(value);
    navigate("/summaries");
  };

  return (
    <SelectionPage
      title="اختار الفصل الدراسي"
      items={semesters}
      loading={loading}
      onSelect={handleSelect}
    />
  );
}
