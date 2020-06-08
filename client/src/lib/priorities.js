export const prioritiesData = [
  { value: 1, label: 'Critical' },
  { value: 2, label: 'High' },
  { value: 3, label: 'Medium' },
  { value: 4, label: 'Low' },
];

export function getPriorityData(priority) {
  return (
    prioritiesData.find((priorityData) => priorityData.value === priority) ||
    null
  );
}
