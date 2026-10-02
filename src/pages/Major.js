import { useContext } from "react";
import { useNavigate } from "react-router-dom";
import { SelectionContext } from "../contexts/SelectionContext";
import { getMajors } from "../api";
import { useFetch } from "../hooks/useFetch";
import SelectionPage from "../components/SelectionPage";

export default function Major() {
  const { setSpecialty } = useContext(SelectionContext);
  const navigate = useNavigate();
  const { data: specialties, loading } = useFetch(getMajors, []);

  const handleSelect = (value) => {
    setSpecialty(value);
    navigate("/level");
  };

  return (
    <SelectionPage
      title="اختار التخصص"
      items={specialties}
      loading={loading}
      onSelect={handleSelect}
    />
  );
}
