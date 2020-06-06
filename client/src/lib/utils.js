export function optionalGet(object, path) {
  return path
    .split('.')
    .reduce(
      (child, pathItem) =>
        child && child[pathItem] !== null && child[pathItem] !== undefined
          ? child[pathItem]
          : null,
      object
    );
}

export function partition(xs, fn) {
  return [xs.filter(fn), xs.filter((x) => !fn(x))];
}
