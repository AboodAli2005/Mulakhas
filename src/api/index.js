import axios from "axios";

const BASE_URL = "https://aug-backpack.runasp.net/api/v1";

export const getMajors = () =>
  axios.get(`${BASE_URL}/majors`).then((res) => res.data.data);

export const getLevels = () =>
  axios.get(`${BASE_URL}/levels`).then((res) => res.data.data);

export const getSemesters = (levelId) =>
  axios
    .get(`${BASE_URL}/semesters`, { params: { levelId } })
    .then((res) => res.data.data);

export const getSubjects = ({ specialtyId, levelId, semesterId }) =>
  axios
    .get(`${BASE_URL}/subjects`, {
      params: {
        SpecialtyId: specialtyId,
        LevelId: levelId,
        SemesterId: semesterId,
      },
    })
    .then((res) => res.data.data.data);

export const getSummaries = ({
  specialtyId,
  levelId,
  semesterId,
  subjectId,
  keyword,
  take,
}) =>
  axios
    .get(`${BASE_URL}/summaries`, {
      params: {
        SpecialtyId: [specialtyId],
        LevelId: levelId,
        SemesterId: semesterId,
        SubjectId: subjectId === "" ? null : Number(subjectId),
        Keyword: keyword,
        Take: take,
      },
    })
    .then((res) => res.data.data.data);

export const getLectures = ({
  specialtyId,
  levelId,
  semesterId,
  subjectId,
  keyword,
  take,
}) =>
  axios
    .get(`${BASE_URL}/lectures`, {
      params: {
        SpecialtyId: [specialtyId],
        LevelId: levelId,
        SemesterId: semesterId,
        SubjectId: subjectId === "" ? null : Number(subjectId),
        Keyword: keyword,
        Take: take,
      },
    })
    .then((res) => res.data.data.data);
