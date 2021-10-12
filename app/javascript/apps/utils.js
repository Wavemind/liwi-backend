// Return current study language code
export const getStudyLanguage = () => {
  const data = document.querySelector(".default_language");
  return data.dataset.default_language;
};

// Return translated hstore with a fallback if the translation is missing
export const getTranslatedText = (hash, language) => {
  if (hash) {
    return hash[language] || hash["en"] || "";
  }
  return "";
};
