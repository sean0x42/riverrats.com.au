// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes#Polyfill

if (!Array.prototype.includes) {
  Object.defineProperty(Array.prototype, "includes", {
    value: (searchElement, n = 0) => {
      if (this === null) {
        throw new TypeError("\"this\" is null or undefined.");
      }

      const o = Object(this);
      const len = o.length >>> 0;
      if (len === 0) {
        return false;
      }

      let k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);

      const sameValueZero = (x, y) => {
        return x === y || (typeof x === "number" && typeof y === "number" && isNaN(x) && isNaN(y));
      };

      while (k < len) {
        if (sameValueZero(o[k], searchElement)) {
          return true;
        }
        k++;
      }

      return false;
    }
  });
}
