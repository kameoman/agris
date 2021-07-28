
    const question = document.querySelectorAll('dt');

    question.forEach(question => {
      question.addEventListener('click', () => {
        // dt の親要素に対してクラスのつけ外し
        question.parentNode.classList.toggle('appear');
      });
    });

