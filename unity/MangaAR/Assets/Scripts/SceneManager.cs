using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneManagerController : MonoBehaviour
{
    // M�todo para cargar la escena vac�a
    public void LoadEmptyScene()
    {
        SceneManager.LoadScene("EmptyScene");
    }

    // M�todo para cargar la escena AR
    public void LoadDemonSlayerV11ARScene()
    {
        SceneManager.LoadScene("DemonSlayerV11");
    }
}
