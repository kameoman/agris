document.addEventListener("turbolinks:load", function() {
  {
    const next = document.getElementById('next');
    const prev = document.getElementById('prev');
    const ul = document.getElementById('ul');
    const slides = ul.children;
    let currentIndex = 0;

    function updateButtons(){
      prev.classList.remove('hidden');
      next.classList.remove('hidden');

      if (currentIndex === 0) {
        prev.classList.add('hidden');
      }
      if (currentIndex === slides.length -1) {
        next.classList.add('hidden');
      }

    }

    function moveSlides(){
      const slideWidth = slides[0].getBoundingClientRect().width;
      ul.style.transform = `translateX(${ -1 * slideWidth * currentIndex}px)`;
    }

    updateButtons();

    next.addEventListener('click', () => {
      currentIndex++;
      updateButtons();
      moveSlides();
    });

    prev.addEventListener('click', () => {
      currentIndex--;
      updateButtons();
      moveSlides();
    });

  }



});

document.addEventListener("turbolinks:load", function() {

  document.getElementById("navbtn").onclick = function(){
    document.querySelector('html').classList.toggle('open');
  }
  document.getElementById("nav-link").onclick = function(){
    document.querySelector('html').classList.remove('open');
  }


});