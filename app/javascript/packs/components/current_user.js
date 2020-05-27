const currentUser = () => {
  const id = +document.querySelector('meta[name="current_user"]').content
  return id === 0 ? null : id
};
  
export { currentUser };