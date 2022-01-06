# minor_words ----

# Start with
tidytext::parts_of_speech %>%
  filter(pos %in% c("Definite Article", "Conjunction", "Preposition"),
         nchar(word) < 4) %>%
  pull(word) %>%
  cat(paste0('"', sort(unique(.)), '"'), sep = ",\n")

# Manually remove extraneous entries
minor_words <-c(
  "a",
  "all",
  "an",
  "and",
  "any",
  "as",
  "at",
  "bar",
  "ben",
  "but",
  "by",
  "cum",
  "et",
  "ex",
  "fer",
  "few",
  "for",
  "her",
  "his",
  "if",
  "in",
  "its",
  "mid",
  "my",
  "no",
  "nor",
  "now",
  "of",
  "off",
  "on",
  "one",
  "our",
  "out",
  "own",
  "per",
  "so",
  "the",
  "to",
  "up",
  "via",
  "why",
  "yet",
  "yon"
  )

names(minor_words) = stringr::str_to_sentence(minor_words)

usethis::use_data(minor_words, overwrite = TRUE)


# known_acronyms ----
known_acronyms <-c(
  "fcc" = "FCC",
  "fda" = "FDA",
  "usda" = "USDA",
  "a1c" = "A1c",
  "hba1c" = "HbA1c"
)

usethis::use_data(known_acronyms, overwrite = TRUE)
