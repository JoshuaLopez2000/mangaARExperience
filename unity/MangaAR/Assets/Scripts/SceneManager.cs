using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneManagerController : MonoBehaviour
{
    // Método para cargar la escena vacía
    public void LoadEmptyScene()
    {
        SceneManager.LoadScene("EmptyScene");
    }

    // Método para cargar la escena AR
    public void LoadDemonSlayerV11ARScene()
    {
        SceneManager.LoadScene("DemonSlayerV11");
    }
}
