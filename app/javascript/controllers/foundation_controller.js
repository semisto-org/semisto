import { Controller } from 'stimulus'

export default class extends Controller {
  initialize() {
    this.initializeAbide()
    this.initializeTooltips()
    this.initializeTertiaryNavigation()
    $(document).foundation()
    if ($('form[data-valid=false]').length) {
      $('form[data-valid=false]').foundation('validateForm')
    }
  }

  initializeAbide() {
    // Add required data attribute to error element for .input-group fields
    $('.input-group').each(() => {
      $(this)
        .siblings('.form-error')
        .attr('data-form-error-for', $(this).find('input').attr('id'))
    })

    $('.input-with-icon').each(() => {
      $(this)
        .siblings('.form-error')
        .attr('data-form-error-for', $(this).find('input').attr('id'))
    })

    // Show errors after form reload (Rails validation)
    // $('form[data-valid=false] input[aria-invalid=true]').each(() => {
    //   $(this).addClass('is-invalid-input')
    //   $(this).closest('.field').find('.form-error').addClass('is-visible')
    // })
  }

  initializeTertiaryNavigation() {
    $('[data-toggle=tertiary-navigation]').on('click', (e) => {
      e.preventDefault()
    })
  }

  initializeTooltips() {
    // Avoid side effects (eg. checking a checkbox) when clicking on a tooltip link
    $('[data-tooltip]').on('click', () => {
      return false
    })

    // Touchscreens: close tooltips on touch anywhere on the screen
    document.addEventListener('touchend', (e) => {
      if (e.target.closest('[data-tooltip]') == null && $('[data-tooltip]').length) {
        $('[data-tooltip]').foundation('hide')
      }
    })
  }
}
