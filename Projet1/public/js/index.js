console.log('Hello world !');

const headerMobileButton = document.querySelector('.header-mobile-icon');
const headerMobileList = document.querySelector('.header-mobile-list');

headerMobileButton.addEventListener('click', () => {
  headerMobileList.classList.toggle('show');
})

// menu déroulant en mobile