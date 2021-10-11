export const getStudyLanguage = () => {
  let data = document.querySelector(".default_language");
  return data.dataset.default_language;
};

export const getTranslatedText = (hash, language) => {
  if (hash) {
    return hash[language] || hash["en"] || "";
  } else {
    return "";
  }
};
