window.onload = () => {
let i = 0;
function piechart(){
  var progress_data = document.getElementsByClassName("Piechart")
  while(i < progress_data.length)
  {
    const dataPie = {
      datasets: [
        {
          data: [progress_data[i].dataset.goal, progress_data[i].dataset.amount_raised],
          backgroundColor: [
            "#e1e1e1",
            "#6565c4",
          ],
          hoverOffset: 4,
        },
      ],
    };
    const configPie = {
      type: "pie",
      data: dataPie,
      options: {
        responsive: true,
        plugins: {
          tooltip: {
            enabled: false
          },
          title: {
            display: true,
            position: 'bottom',
            padding: 4,
            text: "$ " + progress_data[i].dataset.amount_raised + " / $ " + progress_data[i].dataset.goal,
          },
        },
      },
    };
    let element = document.getElementById(progress_data[i].dataset.member_id);
    console.log("element", element);
    new Chart(element, configPie);
    i++;
  } 
}
piechart()
};
