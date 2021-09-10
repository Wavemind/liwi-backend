/**
 * The external imports
 */
import I18n from "i18n-js";

/**
 * Change display of patient date follow those rules
 * Creation date of medical case - patient date of birth
 *
 * Rules
 * < 7 days | display age in days -> 6 days old
 * >= 7 days < 31 days | display age in weeks ex: lower rounding 3.5 weeks become 3 weeks -> 3 weeks old
 * >= 31 days < 730 | display age in months (1 month = 30.4375) ex: Lower rounding 3.5 months become 3 months -> 3 months old
 * >= 24 month | display age in years ex: Lower rounding 3.5 year -> 3 years old
 *
 * @returns [String] human readable date
 */
export default ageInDays => {
  let readableDate = "";
  if (ageInDays < 7) {
    readableDate = I18n.t("date.days", {
      value: ageInDays
    });
  }

  if (ageInDays >= 7 && ageInDays < 31) {
    readableDate = I18n.t("date.weeks", {
      value: Math.floor(ageInDays / 7)
    });
  }

  if (ageInDays >= 31 && ageInDays < 730) {
    readableDate = I18n.t("date.months", {
      value: Math.floor(ageInDays / 30.4375)
    });
  }

  if (ageInDays > 730) {
    readableDate = I18n.t("date.years", {
      value: Math.floor(ageInDays / 365.25)
    });
  }

  return readableDate;
};
