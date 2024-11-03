import { applauncher } from "./applauncher.js";
import { bar } from "./bar.js";
App.config({
  style: "./style.css",
  windows: [
    bar(),
    applauncher
  ]
})
