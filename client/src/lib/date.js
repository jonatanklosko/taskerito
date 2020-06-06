export function formatDatePart(isoString) {
  const date = new Date(isoString);
  return date.toLocaleDateString('en-US', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });
}
