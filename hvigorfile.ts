import { appTasks } from '@ohos/hvigor-ohos-plugin';
import * as fs from 'fs';
import * as path from 'path';

function loadSigningOverrides(): Record<string, unknown> | null {
  const configPath = path.resolve(__dirname, 'local-signing.json');
  if (!fs.existsSync(configPath)) {
    return null;
  }
  const content = fs.readFileSync(configPath, 'utf-8');
  const data = JSON.parse(content);
  return {
    signingConfig: {
      type: 'HarmonyOS',
      material: {
        certpath: data.certpath,
        keyAlias: data.keyAlias,
        keyPassword: data.keyPassword,
        profile: data.profile,
        signAlg: data.signAlg || 'SHA256withECDSA',
        storeFile: data.storeFile,
        storePassword: data.storePassword
      }
    }
  };
}

const signingOverrides = loadSigningOverrides();

export default {
    system: appTasks,
    plugins: [],
    ...(signingOverrides && {
        config: {
            ohos: {
                overrides: signingOverrides
            }
        }
    })
}
