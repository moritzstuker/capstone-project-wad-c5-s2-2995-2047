document.addEventListener('turbolinks:load', () => {
  function checkTime(i) {
    return (i < 10) ? "0" + i : i;
  }

  function startTime() {
    let today = new Date();
    const options = {
      weekday: 'short',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    };
    document.getElementById("clock").innerHTML = today.toLocaleDateString('fr-CH', options);
    t = setTimeout(function () {
      startTime()
    }, 500);
  }
  startTime();
});
