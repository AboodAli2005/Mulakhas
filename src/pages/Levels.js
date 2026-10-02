import { useContext } from "react";
import { useNavigate } from "react-router-dom";
import { SelectionContext } from "../contexts/SelectionContext";
import { getLevels } from "../api";
import { useFetch } from "../hooks/useFetch";
import SelectionPage from "../components/SelectionPage";

export default function Levels() {
  const { setLevel } = useContext(SelectionContext);
  const navigate = useNavigate();
  const { data: levels, loading } = useFetch(getLevels, []);

  const handleSelect = (value) => {
    setLevel(value);
    navigate("/semester");
  };

  return (
    <SelectionPage
      title="اختار السنة الدراسية"
      items={levels}
      loading={loading}
      onSelect={handleSelect}
    />
  );
}
