export function formatDatePart(isoString) {
  const date = new Date(isoString);
  return date.toLocaleDateString('en-US', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });
}

export function formatTimePart(isoString) {
  const date = new Date(isoString);
  return date.toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
  });
}

export function formatDateTime(isoString) {
  return `${formatTimePart(isoString)}, ${formatDatePart(isoString)}`;
}
